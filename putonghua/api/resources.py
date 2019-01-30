import random
import re
import datetime
from decimal import Decimal
from django.conf.urls import url
from django.http import HttpResponse, HttpResponseBadRequest, Http404
from django.db.models import Q, Prefetch
from django.core.paginator import Paginator, InvalidPage
from django.contrib import messages
from django.contrib.auth import authenticate, login
from django.core.cache import cache
import sys
from django.core.mail import send_mail
from userena import signals as userena_signals
from userena import settings as userena_settings
from tastypie import resources, fields, http
from tastypie.resources import ModelResource
from tastypie.bundle import Bundle
from tastypie.exceptions import NotFound
from tastypie.authorization import Authorization, ReadOnlyAuthorization, DjangoAuthorization
from tastypie.authentication import SessionAuthentication
from tastypie.utils import trailing_slash
from tastypie.serializers import Serializer
from tastypie.resources import ModelResource, ALL, ALL_WITH_RELATIONS


import zhongguolib
import json
from putonghua.core.models import (User,
                                   Word,
                                   WordReference,
                                   UserCard,
                                   CardList,
                                   Search,
                                   Country,
                                   PubCardList,
                                   Lesson,
                                   SearchHistoryItem,
                                   StudyContent,
                                   ExampleSentence,
                                   UserSentenceCard,
                                   SentenceCardList,
                                   VideoStudyItem,
                                   AudioStudyItem,
                                   ChineseName,
                                   SuggestWord,
								   WordOfTheDay,
                                   FeaturedContent,
                                   )
from tastypie.cache import SimpleCache

from putonghua.api.validation import AuthenticationForm, ExtendedSignupForm

import stripe


def build_content_type(format, encoding='utf-8'):
    """
    Appends character encoding to the provided format if not already present.
    """
    if 'charset' in format:
        return format

    return "%s; charset=%s" % (format, encoding)


class UserLoggedIn(ModelResource):
    def is_authenticated(self, request):
        if str(request.user) == 'AnonymousUser':
            return http.HttpUnauthorized()
            # return self.create_response(request, "Not logged in", status=403)
        else:
            super().is_authenticated(request)



class CountryResource(ModelResource):
    class Meta:
        queryset = Country.objects.all()
        authorization = DjangoAuthorization()
        include_resource_uri = False
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        cache = SimpleCache(timeout=60 * 60)


class UserResource(ModelResource):
    class Meta:
        authorization = DjangoAuthorization()
        include_resource_uri = False
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']

    def prepend_urls(self):
        return [
            url(r"^login%s$" % (trailing_slash()), self.wrap_view('login'), name="api_user_login"),
            url(r"^signup%s$" % (trailing_slash()), self.wrap_view('signup'), name="api_user_signup"),
            url(r"^profile%s$" % (trailing_slash()), self.wrap_view('profile'), name="api_user_profile"),
            url(r"^subscription%s$" % (trailing_slash()), self.wrap_view('subscription'), name="api_user_subscription")
        ]

    def login(self, request, **kwargs):
        # self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        form = AuthenticationForm(request.POST, request.FILES)

        if form.is_valid():

            user = authenticate(identification=form.cleaned_data['identification'],
                                password=form.cleaned_data['password'])

            if user.is_active:
                login(request, user)

                # if remember_me:
                #    request.session.set_expiry(userena_settings.USERENA_REMEMBER_ME_DAYS[1] * 86400)

                request.session.set_expiry(0)

                if userena_settings.USERENA_USE_MESSAGES:
                    messages.success(request, 'You have been signed in.', fail_silently=True)

                # send a signal that a user has signed in
                userena_signals.account_signin.send(sender=None, user=user)

                return self.create_response(request, {
                    'success': True,
                    'data': {
                        'sid': request.session.session_key,
                        'uid': user.id,
                        'id': user.id,
                        'uname': user.username,
                        'email': user.email,
                        'has_active_subscription': user.has_active_subscription,
                        'username': user.username,
                        'location': user.location.id if user.location else None,
                        'chinese_level': user.chinese_level,
                    },
                    'message': 'OK'
                })

            else:
                return self.create_response(request, {
                    'success': False,
                    'errors': {
                        '__all__': [
                            "Your account has not yet been activated. Please check your email and follow the instructions we sent you to active your account. If you didn't receive an email please Contact Us"
                        ]
                    },
                    'data': {
                        'uid': user.id,
                        'uname': user.username,
                        'email': user.email
                    }
                })
        else:
            return self.create_response(request, {
                'success': False,
                'errors': form.errors
            })

    def signup(self, request, **kwargs):
        self.throttle_check(request)
        self.method_check(request, ['post'])
        form = ExtendedSignupForm(request.POST, request.FILES)
        if form.is_valid():
            print('valid')
            user = form.save()
            print('i am here1')
            #user.save()

            # Send the signup complete signal
            userena_signals.signup_complete.send(sender=None, user=user)
            
            # send_mail(
            #     'test',
            #     'test',
            #      'misha.dima1999@yandex.ua', ['korsunowk@yandex.ua',]
            # )

            # A new signed user should logout the old one.
            # if (userena_settings.USERENA_SIGNIN_AFTER_SIGNUP and
            #     not userena_settings.USERENA_ACTIVATION_REQUIRED):
            #     user = authenticate(identification=user.email, check_password=False)
            #     login(request, user)

            resp = self.create_response(request, {
                'success': True
            })
            print('i am here2')

        else:
            resp = self.create_response(request, {
                'success': False,
                'errors': form.errors
            })
        # print(resp)
        # print(dir(resp))
        return resp
########################################################################################################################################
    def subscription(self, request, **kwargs):
        def deserialize_subscription(s):
            result = {}
            for field in s._meta.fields:
                try:
                    value = getattr(s, field.name)
                except KeyError:
                    value = None
                if isinstance(value, datetime.datetime):
                    value = value.isoformat()
                if isinstance(value, Customer):
                    value = value.subscriber.id
                if isinstance(value, Decimal):
                    value = str(value)
                result[field.name] = value
            return result
        self.method_check(request, ['get', 'post', 'delete'])
        from djstripe.models import Customer
        from djstripe.settings import CANCELLATION_AT_PERIOD_END
        #
        if request.method == 'POST':
            try:
                deserialized = self.deserialize(request, request.body,
                                                format=request.META.get('CONTENT_TYPE', 'application/json'))
                stripe_token = deserialized.get('stripe_token')
                if request.user.is_authenticated():
                    user = request.user
                    customer = Customer.get_or_create(subscriber=user)[0]
                else:
                    user = User.objects.get(username=deserialized.get('username'))
                    customer = Customer.get_or_create(subscriber=user)[0]
                # plan = request.POST.get('plan')
                plan = "monthly"
                if stripe_token and plan:
                    customer.update_card(stripe_token)
                    customer.subscribe(plan=plan)
                    subscription = deserialize_subscription(customer.current_subscription)
                    data = {'subscription': subscription}
                    resp = self.create_response(request, data)
                else:
                    if not plan:
                        resp = http.HttpBadRequest(
                            "\"plan\" is missing or incorrect"
                        )
                    elif not stripe_token:
                        resp = http.HttpBadRequest(
                            "\"stripe_token\" is missing or incorrect"
                        )
            except Exception as inst:
                print(inst)
                resp = http.HttpBadRequest(inst)
                #resp = http.HttpBadRequest("Something went wrong processing the payment")

            return resp
        if request.user.is_authenticated():
            user = request.user
            customer = Customer.objects.get(subscriber=user)
            if hasattr(customer, 'current_subscription'):
                customer.current_subscription.plan = "monthly"
                customer.current_subscription.save()

            if request.method == 'GET':
                customer = Customer.objects.get(subscriber=user)
                if user.is_staff :
                    # Unlimited subscription
                    data = {'subscription':
                                {"amount": "7.00", "cancel_at_period_end": False,
                                 "canceled_at": None,
                                 "created": "2016-02-21T18:42:43.093070+00:00",
                                 "current_period_end": "2099-03-22T18:42:41+00:00",
                                 "current_period_start": "2016-02-21T18:42:41+00:00",
                                 "customer": customer.id, "ended_at": None, "id": 1,
                                 "modified": "2016-02-21T18:42:43.096649+00:00",
                                 "plan": "monthly", "quantity": 1,
                                 "start": "2016-02-21T18:42:41+00:00",
                                 "status": "trialing", "trial_end":
                                     "2016-03-22T18:42:41+00:00",
                                 "trial_start": "2016-02-21T18:42:41+00:00"}}
                    resp = self.create_response(request, data)
                    return resp
                else:
                    # Not staff
                    try:
                        subscription = deserialize_subscription(customer.current_subscription)
                        data = {'subscription': subscription}
                        resp = self.create_response(request, data)
                    except BaseException:
                        data = {'subscription': None}
                        resp = self.create_response(request, data)
            elif request.method == 'DELETE':
                try:
                    customer.cancel_subscription(
                        # Cancel at period end
                        at_period_end=True
                    )
                    user.unsubscribe_status = True
                    user.save()
                    data = {'success': True}
                    resp = self.create_response(request, data)
                except BaseException as e:
                    print(e)
                    resp = http.HttpBadRequest(
                        e
                        #"Something went wrong cancelling the subscription."
                    )
            else:
                resp = http.HttpBadRequest('Wrong HTTP method: {}'.format(request.method))
            return resp
        else:
            return http.HttpUnauthorized()
###########################################################################################################################################
    def profile(self, request, **kwargs):
        from djstripe.models import Customer
        r = request
        self.method_check(request, ['get', 'post'])

        if request.user.is_authenticated():
            user = request.user
            if request.method == 'POST':
                errors = {}

                if request.POST.get('currentPassword') and not user.check_password(request.POST.get('currentPassword')):
                    errors['currentPassword'] = ['Wrong password!']

                currentPassword = request.POST.get('currentPassword')
                newPassword = request.POST.get('password1')
                confirmPassword = request.POST.get('password2')
                location = request.POST.get('location')
                chineseLevel = request.POST.get('chinese_level')

                if currentPassword and not user.check_password(currentPassword):
                    errors['currentPassword'] = ["Wrong password!"]

                if (newPassword or confirmPassword) and (newPassword != confirmPassword):
                    errors['confirmPassword'] = ["Passwords Mismatch!"]

                if errors != {}:
                    return self.create_response(request, {'success': False, 'errors': errors})
                else:
                    if newPassword:
                        user.set_password(newPassword)
                    user.location_id = user.location_id if not location else location
                    user.chinese_level = user.chinese_level if not chineseLevel else chineseLevel
                    user.save()
                    return self.create_response(request, {'success': True})
            else:
                if request.user.unsubscribe_status:
                    customer_object = Customer.objects.get(subscriber=request.user)
                    print(str(customer_object))
                    customer_stripe_id = customer_object.stripe_id
                    customer_id = stripe.Customer.retrieve(customer_stripe_id)
                    customer = Customer.objects.get(subscriber=user)
                    subscription_cancel = customer.current_subscription.canceled_at
                    user_data = {
                            'id': request.session.session_key,
                            'success': True,
                            'user': {
                                'sid': request.session.session_key,
                                'uid': user.id,
                                'id': user.id,
                                'uname': user.username,
                                'email': user.email,
                                'has_active_subscription': user.has_active_subscription,
                                'username': user.username,
                                'location': user.location.id if user.location else None,
                                'chinese_level': user.chinese_level,
                                'unsubscribe_status': user.unsubscribe_status,
                                'canceled_at': subscription_cancel
                            },

                        }
                    if user.is_staff or not customer_id.subscriptions.data:
                        print('if user.is--------------')
                        return self.create_response(request, user_data)
                    else:
                        return self.create_response(request, user_data)
                else:
                    return self.create_response(request,
                                                {
                                                    'id': request.session.session_key,
                                                    'success': True,
                                                    'user': {
                                                        'sid': request.session.session_key,
                                                        'uid': user.id,
                                                        'id': user.id,
                                                        'uname': user.username,
                                                        'email': user.email,
                                                        'has_active_subscription': user.has_active_subscription,
                                                        'username': user.username,
                                                        'location': user.location.id if user.location else None,
                                                        'chinese_level': user.chinese_level,
                                                        'unsubscribe_status': user.unsubscribe_status
                                                    },
                                                })

        else:
            return self.create_response(request,
                                        {
                                            'id': request.session.session_key,
                                            'success': False,
                                            'user': 'AnonymousUser'
                                        })


class SearchResource(ModelResource):
    class Meta:
        queryset = Search.objects.all().order_by('-timestamp').distinct('text')
        authorization = Authorization()
        include_resource_uri = False
        excludes = ['id', 'timestamp']
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/latest%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('latest'), name="api_latest_searches"),
        ]

    def latest(self, request, **kwargs):
        self.throttle_check(request)
        self.method_check(request, ['get'])

        # searches = [search for search in Search.objects.exclude(text='').distinct('text')[:7]]
        searches = [search for search in Search.objects.all().order_by('-timestamp')[:7]]
        searches = [search.text for search in sorted(searches, key=lambda x: x.timestamp.timestamp())]
        searches = list(set(searches))
        return self.create_response(request, searches)


class UserCardResource(ModelResource):
    word = fields.ToOneField('putonghua.api.resources.WordResource', 'word', full=True, null=False, readonly=True)

    class Meta:
        queryset = UserCard.objects.select_related('owner').select_related('word').all().order_by('id')
        authorization = Authorization()
        include_resource_uri = False
        detail_allowed_methods = ['get', 'put']
        resource_name = 'card'

    def obj_get_list(self, bundle, **kwargs):
        qs = super(UserCardResource, self).obj_get_list(bundle, **kwargs)
        return qs.filter(owner=bundle.request.user)


class PubCardListResource(UserLoggedIn):
    cards = fields.ToManyField('putonghua.api.resources.PubWordResource', 'cards', full=True, null=False, readonly=True,
                               related_name='cards', use_in=('list', 'detail'))

    class Meta:
        queryset = PubCardList.objects.all().order_by('id')
        include_resource_uri = False
        always_return_data = True
        resource_name = 'pubcategory'
       # cache = SimpleCache(timeout=60 * 60)

    def get_object_list(self, request):
        return super().get_object_list(request).prefetch_related('cards').prefetch_related('cards__references')

    # def get_list(self, bundle, **kwargs):
    #    qs = cache.get('pubcards')
    #    if not qs:
    #        qs = super().get_list(bundle, **kwargs)
    #        cache.set('pubcards', qs)
    #    return qs

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('categories_copy'), name="api_categories_copy"),
            url(r"^(?P<resource_name>%s)/word/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('word_copy'), name="api_word_copy"),
            url(r"^(?P<resource_name>%s)/nocategories%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('nocategories'), name="api_pubcardlist_nocategories"),
        ]

    def categories_copy(self, request, **kwargs):

        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        categories_names = deserialized.get('categories_names')

        categories = PubCardList.objects.filter(name__in=categories_names)
        copied = [category.convert_to_private(newowner=request.user) for category in categories]
        data = {
            """
                'categories': [
                    self.full_dehydrate(self.build_bundle(request=request, obj=category)) for category in copied
                ]
            """
        }
        return self.create_response(request, data)

    def almost_full_dehydrate(self, bundle, for_list=False):
        """
        Given a bundle with an object instance, extract the information from it
        to populate the resource.
        """
        use_in = ['all', 'list' if for_list else 'detail']

        # Dehydrate each field.
        for field_name, field_object in self.fields.items():
            # If it's not for use in this mode, skip
            field_use_in = getattr(field_object, 'use_in', 'all')
            if callable(field_use_in):
                if not field_use_in(bundle):
                    continue
            else:
                if field_use_in not in use_in:
                    continue

            # A touch leaky but it makes URI resolution work.
            if getattr(field_object, 'dehydrated_type', None) == 'related':
                field_object.api_name = self._meta.api_name
                field_object.resource_name = self._meta.resource_name
            if field_name is not 'cards':
                bundle.data[field_name] = field_object.dehydrate(bundle, for_list=for_list)

            # Check for an optional method to do further dehydration.
            method = getattr(self, "dehydrate_%s" % field_name, None)

            if method:
                bundle.data[field_name] = method(bundle)

        bundle = self.dehydrate(bundle)
        return bundle

    def nocategories(self, request, **kwargs):
        def generate_data(obj, count):
            bundle = self.build_bundle(request=request, obj=obj)
            print(bundle.obj)
            if 'cards' in bundle.data:
                del(bundle.data['cards'])
            result = self.almost_full_dehydrate(bundle)
            print(result.data.keys())
            result.data['cards_count'] = count
            return result
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['get'])
        pubcardlists_with_count = [(a, a.cards.count()) for a in PubCardList.objects.all()]
        result_dict = [ generate_data(cardlist, count) for (cardlist, count) in pubcardlists_with_count]
        data = {
            'objects': result_dict
        }
        return self.create_response(request, data)

    def word_copy(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        word_id = deserialized.get('word_id')
        word_id = [word_id] if isinstance(word_id, int) else word_id
        source_list_id = deserialized.get('source_list_id')
        destination_list_id = deserialized.get('destination_list_id')

        # determine ordering depending on the sign of the difference of destination_list_id and source_list_id
        order = '-' if destination_list_id - source_list_id < 0 else ''
        source = PubCardList.objects.get(id=source_list_id)

        destination = CardList.objects.get(owner=request.user, id=destination_list_id)
        words = list(Word.objects.filter(id__in=word_id))
        # we need both cardlists to be present for a copy operation
        if source and destination:
            try:
                # copy the cards and return the newly created card to the client
                cards = source.copy_to(words, destination)
                data = {
                    'cards': [
                        UserCardResource.full_dehydrate(UserCardResource(), Bundle(obj=card, request=request))
                        for card in cards
                        ]
                }
                return self.create_response(request, data)
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest(
                'PubCardListResource.word_copy() wrong categories %s, %s' % (source, destination))


class CardListResource(UserLoggedIn):
    cards = fields.ToManyField('putonghua.api.resources.UserCardResource', 'cards', full=True, null=True, readonly=True,
                               related_name='cards')

    class Meta:
        queryset = CardList.objects.prefetch_related('cards').prefetch_related('cards__word').all().order_by('id')
        authorization = Authorization()
        include_resource_uri = False
        always_return_data = False
        resource_name = 'category'

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('categories_copy'), name="api_categories_copy"),
            url(r"^(?P<resource_name>%s)/word/add%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('word_add'), name="api_word_adds"),
            url(r"^(?P<resource_name>%s)/word/delete%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('word_delete'), name="api_word_delete"),
            url(r"^(?P<resource_name>%s)/word/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('word_copy'), name="api_word_copy"),
            url(r"^(?P<resource_name>%s)/word/move%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('word_move'), name="api_word_move"),
            url(r"^(?P<resource_name>%s)/nocategories%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('nocategories'), name="api_cardlist_nocategories"),
        ]
    def obj_get_list(self, bundle, **kwargs):
        
        qs = super().obj_get_list(bundle, **kwargs)
        if str(bundle.request.user) != 'AnonymousUser':
            return qs.filter(owner=bundle.request.user)
        else:
            return qs.none()

    def almost_full_dehydrate(self, bundle, for_list=False):
        """
        Given a bundle with an object instance, extract the information from it
        to populate the resource.
        """
        use_in = ['all', 'list' if for_list else 'detail']
        # Dehydrate each field.
        for field_name, field_object in self.fields.items():
            # If it's not for use in this mode, skip
            field_use_in = getattr(field_object, 'use_in', 'all')
            if callable(field_use_in):
                if not field_use_in(bundle):
                    continue
            else:
                if field_use_in not in use_in:
                    continue

            # A touch leaky but it makes URI resolution work.
            if getattr(field_object, 'dehydrated_type', None) == 'related':
                field_object.api_name = self._meta.api_name
                field_object.resource_name = self._meta.resource_name
            if field_name is not 'cards':
                bundle.data[field_name] = field_object.dehydrate(bundle, for_list=for_list)

            # Check for an optional method to do further dehydration.
            method = getattr(self, "dehydrate_%s" % field_name, None)

            if method:
                bundle.data[field_name] = method(bundle)

        bundle = self.dehydrate(bundle)
        return bundle

    def obj_delete_list(self, bundle, **kwargs):
        print('obj_delete_list')
        return
        qs = super(CardListResource, self).obj_get_list(bundle, **kwargs)
        return qs.filter(owner=bundle.request.user)
    
    def obj_create(self, bundle, **kwargs):
        kwargs['owner_id'] = bundle.request.user.id
        super(CardListResource, self).obj_create(bundle, **kwargs)
        return bundle

    def obj_update(self, bundle, **kwargs):
        bundle = super().obj_update(bundle, **kwargs)
        print("wow!")
        return bundle

    def categories_copy(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        
        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)
        
        categories_names = deserialized.get('categories_names')
        
        categories = CardList.objects.filter(name__in=categories_names, owner=request.user)
        copied = [category.copy(request.user) for category in categories]
        
        data = {
            'categories': [
                self.full_dehydrate(self.build_bundle(request=request, obj=category)) for category in copied
                ]
        }
        return self.create_response(request, data)


    def word_add(self, request, **kwargs):        
        SessionAuthentication().is_authenticated(request)
        if not request.user.id:
            return http.HttpUnauthorized()

        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        word_id = deserialized.get('word_id')
        name = deserialized.get('name')
        cardlist = CardList.objects.filter(owner=request.user, name=name)
        if cardlist:
            try:
                cardlist[0].add_word(word_id)
                return http.HttpCreated()
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong category %s' % cardlist)

    def word_delete(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        word_id = deserialized.get('word_id')
        word_id = [word_id] if isinstance(word_id, int) else word_id
        list_id = deserialized.get('list_id')

        cardlist = CardList.objects.filter(owner=request.user, id=list_id)
        if cardlist:
            try:
                cardlist[0].remove_words(word_id)
                data = {
                    'cards': [
                        UserCardResource.full_dehydrate(UserCardResource(), Bundle(obj=card, request=request))
                        for card in cardlist[0].cards.all()
                        ]
                }
                return self.create_response(request, data)
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong category %s' % cardlist)

    def word_copy(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        word_id = deserialized.get('word_id')
        word_id = [word_id] if isinstance(word_id, int) else word_id
        source_list_id = deserialized.get('source_list_id')
        destination_list_id = deserialized.get('destination_list_id')

        # determine ordering depending on the sign of the difference of destination_list_id and source_list_id
        order = '-' if destination_list_id - source_list_id < 0 else ''
        cardlists = CardList.objects \
            .filter(owner=request.user, id__in=[source_list_id, destination_list_id]) \
            .order_by(order + 'id')

        cards = list(UserCard.objects.filter(owner=request.user, word_id__in=word_id))

        # we need both cardlists to be present for a copy operation

        if len(cardlists) == 2:
            source, destination = cardlists
            try:
                # copy the cards and return the newly created card to the client
                cards = source.copy_to(cards, destination)
                data = {
                    'cards': [
                        UserCardResource.full_dehydrate(UserCardResource(), Bundle(obj=card, request=request))
                        for card in cards
                        ]
                }
                return self.create_response(request, data)
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong categories %s' % cardlists)

    def word_move(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        word_id = deserialized.get('word_id')
        word_id = [word_id] if isinstance(word_id, int) else word_id
        source_list_id = deserialized.get('source_list_id')
        destination_list_id = deserialized.get('destination_list_id')

        # determine ordering depending on the sign of the difference of destination_list_id and source_list_id
        order = '-' if destination_list_id - source_list_id < 0 else ''
        cardlists = CardList.objects \
            .filter(owner=request.user, id__in=[source_list_id, destination_list_id]) \
            .order_by(order + 'id')

        cards = list(UserCard.objects.filter(owner=request.user, word_id__in=word_id))

        # we need both cardlists to be present for a copy operation
        if len(cardlists) == 2:
            source, destination = cardlists
            try:
                # copy the cards and return the newly created card to the client
                cards = source.move_to(cards, destination)

                data = {
                    'source_cards': [
                        UserCardResource.full_dehydrate(UserCardResource(), Bundle(obj=card, request=request))
                        for card in source.cards.all()
                        ],
                    'destination_cards': [
                        UserCardResource.full_dehydrate(UserCardResource(), Bundle(obj=card, request=request))
                        for card in destination.cards.all()
                        ]
                }
                return self.create_response(request, data)
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong categories %s' % cardlists)

    def mark_tested(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        #print(request.BODY['id'])
        #return self.create_response(request, data)

    def nocategories(self, request, **kwargs):
        def generate_data(obj, cards_count, learned_cards_count):
            bundle = self.build_bundle(request=request, obj=obj)
            if 'cards' in bundle.data:
                del(bundle.data['cards'])
            result = self.almost_full_dehydrate(bundle)
            #print(result.data.keys())
            result.data['cards_count'] = cards_count
            # card is considered learned if it's tested at least once
            # and it's score is >= 50%
            result.data['learned_cards_count'] = learned_cards_count
            return result

        self.is_authenticated(request)
        if str(request.user) == 'AnonymousUser':
            return self.create_response(request, "Not logged in", status=403)

        self.throttle_check(request)
        self.method_check(request, ['get'])
        cardlists_with_count = [(a, a.cards.count(), len([card for card in a.cards.all() if (card.times_tested > 0) and (card.score >= (card.times_tested * 2))])) for a in CardList.objects.filter(owner=request.user)]
        result_dict = [generate_data(cardlist, cards_count, learned_cards_count) for (cardlist, cards_count, learned_cards_count) in cardlists_with_count]
        data = {
            'objects': result_dict
        }
        #print("____________________________________________________________________________")
        #Word.objects.filter(id__gt=336523, id__lt=336623)
        #try:
        #    kerkkgr = PubCardList.objects.filter(name='Measure Words - Intermediate')[0].cards
        #    for word in Word.objects.filter(id__gt=356523, id__lt=356623):
        #        kerkkgr.add(word)
        #except:
        #    print(sys.exc_info())
        #print("____________________________________________________________________________")
        
        #PubCardList.objects.filter(name='Measure Words - Intermediate')[0].cards.clear()
        
        return self.create_response(request, data)


class UserSentenceCardResource(ModelResource):
    sentence = fields.ToOneField('putonghua.api.resources.SentenceResource', 'sentence', full=True, null=False,
                                 readonly=True)

    class Meta:
        queryset = UserSentenceCard.objects.all().order_by('id')
        authorization = Authorization()
        include_resource_uri = False
        detail_allowed_methods = ['get', 'put']
        resource_name = 'sentencecard'

    def obj_get_list(self, bundle, **kwargs):
        qs = super(UserSentenceCardResource, self).obj_get_list(bundle, **kwargs)
        return qs.filter(owner=bundle.request.user)


class SentenceCardListResource(UserLoggedIn):
    cards = fields.ToManyField('putonghua.api.resources.UserSentenceCardResource', 'cards', full=True, null=True,
                               readonly=True, related_name='cards')

    class Meta:
        queryset = SentenceCardList.objects.all().order_by('id')
        authorization = Authorization()
        include_resource_uri = False
        always_return_data = True
        resource_name = 'sentencecategory'

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('categories_copy'), name="api_categories_copy"),
            url(r"^(?P<resource_name>%s)/sentence/add%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('sentence_add'), name="api_sentence_adds"),
            url(r"^(?P<resource_name>%s)/sentence/delete%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('sentence_delete'), name="api_sentence_delete"),
            url(r"^(?P<resource_name>%s)/sentence/copy%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('sentence_copy'), name="api_sentence_copy"),
            url(r"^(?P<resource_name>%s)/sentence/move%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('sentence_move'), name="api_sentence_move"),
        ]

    def obj_get_list(self, bundle, **kwargs):
        qs = super(SentenceCardListResource, self).obj_get_list(bundle, **kwargs)
        if str(bundle.request.user) != 'AnonymousUser':
            return qs.filter(owner=bundle.request.user)
        else:
            return qs.none()

    def obj_delete_list(self, bundle, **kwargs):
        qs = super(SentenceCardListResource, self).obj_get_list(bundle, **kwargs)
        return qs.filter(owner=bundle.request.user)

    def obj_create(self, bundle, **kwargs):
        kwargs['owner_id'] = bundle.request.user.id
        return super(SentenceCardListResource, self).obj_create(bundle, **kwargs)

    def categories_copy(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        categories_names = deserialized.get('categories_names')

        categories = SentenceCardList.objects.filter(name__in=categories_names, owner=request.user)
        copied = [category.copy(request.user) for category in categories]

        data = {
            'categories': [
                self.full_dehydrate(self.build_bundle(request=request, obj=category)) for category in copied
                ]
        }

        return self.create_response(request, data)

    def sentence_add(self, request, **kwargs):
        SessionAuthentication().is_authenticated(request)
        if not request.user.id:
            return http.HttpUnauthorized()

        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        sentence_id = deserialized.get('sentence_id')
        name = deserialized.get('name')
        cardlist = SentenceCardList.objects.filter(owner=request.user, name=name)

        if cardlist:
            try:
                cardlist[0].add_sentence(sentence_id)
                return http.HttpCreated()
            except Word.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong category %s' % cardlist)

    def sentence_delete(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])
        
        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        sentence_id = deserialized.get('sentence_id')
        sentence_id = [sentence_id] if isinstance(sentence_id, int) else sentence_id
        list_id = deserialized.get('list_id')
        cardlist = SentenceCardList.objects.filter(owner=request.user, id=list_id)
        if cardlist:
            try:
                cardlist[0].remove_sentences(sentence_id)
                data = {
                    'cards': [
                        UserSentenceCardResource.full_dehydrate(UserSentenceCardResource(),
                                                                Bundle(obj=card, request=request))
                        for card in cardlist[0].cards.all()
                        ]
                }
                
                return self.create_response(request, data)
            except ExampleSentence.DoesNotExist as e:
                print('7')
                return http.HttpBadRequest(e.message)
            
        else:
            return http.HttpBadRequest('wrong categoriy %s' % cardlist)

    def sentence_copy(self, request, **kwargs):
        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        sentence_id = deserialized.get('sentence_id')
        sentence_id = [sentence_id] if isinstance(sentence_id, int) else sentence_id
        source_list_id = deserialized.get('source_list_id')
        destination_list_id = deserialized.get('destination_list_id')

        # determine ordering depending on the sign of the difference of destination_list_id and source_list_id
        order = '-' if destination_list_id - source_list_id < 0 else ''
        cardlists = SentenceCardList.objects \
            .filter(owner=request.user, id__in=[source_list_id, destination_list_id]) \
            .order_by(order + 'id')

        cards = list(UserSentenceCard.objects.filter(owner=request.user, sentence_id__in=sentence_id))

        # we need both cardlists to be present for a copy operation
        if len(cardlists) == 2:
            source, destination = cardlists
            try:
                # copy the cards and return the newly created card to the client
                cards = source.copy_to(cards, destination)
                data = {
                    'cards': [
                        UserSentenceCardResource.full_dehydrate(UserSentenceCardResource(),
                                                                Bundle(obj=card, request=request))
                        for card in cards
                        ]
                }
                return self.create_response(request, data)
            except ExampleSentence.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
        else:
            return http.HttpBadRequest('wrong categories %s' % cardlists)

    def sentence_move(self, request, **kwargs):

        self.is_authenticated(request)
        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        sentence_id = deserialized.get('sentence_id')
        sentence_id = [sentence_id] if isinstance(sentence_id, int) else sentence_id
        
        source_list_id = deserialized.get('source_list_id')
        
        destination_list_id = deserialized.get('destination_list_id')
        
        # determine ordering depending on the sign of the difference of destination_list_id and source_list_id
        
        order = '-' if destination_list_id - source_list_id < 0 else ''
        cardlists = SentenceCardList.objects \
            .filter(owner=request.user, id__in=[source_list_id, destination_list_id]) \
            .order_by(order + 'id')
        
        cards = list(UserSentenceCard.objects.filter(owner=request.user, sentence_id__in=sentence_id))
        
        # we need both cardlists to be present for a copy operation
        if len(cardlists) == 2:
            source, destination = cardlists
            try:
                # copy the cards and return the newly created card to the client
                cards = source.move_to(cards, destination)
                data = {
                    'source_cards': [
                        UserSentenceCardResource.full_dehydrate(UserSentenceCardResource(), Bundle(obj=card, request=request))
                        for card in source.cards.all()
                        ],
                    'destination_cards': [
                        UserSentenceCardResource.full_dehydrate(UserSentenceCardResource(), Bundle(obj=card, request=request))
                        for card in destination.cards.all()
                        ]
                }
                return self.create_response(request, data)
            except ExampleSentence.DoesNotExist as e:
                return http.HttpBadRequest(e.message)
            
        else:
            return http.HttpBadRequest('wrong categories %s' % cardlists)


    def dehydrate(self, bundle):
        nocategories = bool(int(bundle.request.GET.get('nocategories', 0)))
        if nocategories:
            del (bundle.data['cards'])
        return super().dehydrate(bundle)

class SentenceResource(ModelResource):
    categories = fields.ToManyField(SentenceCardListResource, 'categories', null=True, readonly=True)

    class Meta:
        queryset = ExampleSentence.objects.all()
        authorization = ReadOnlyAuthorization()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']
        include_resource_uri = False
        resource_name = 'sentence'
        excludes = [
            'sound_file',
        ]
        cache = SimpleCache(timeout=60 * 60)

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>{0})/(?P<sentence_id>\d+)/voice{1}".format(self._meta.resource_name,
                                                                                trailing_slash()),
                self.wrap_view('voice'), name="api_sentence_voice"),
        ]

    def voice(self, request, **kwargs):
        """
            Returns URL to mp3 sound file with the sentence pronounciation
        """

        self.method_check(request, allowed=['get'])

        sentence_id = int(kwargs['sentence_id'])
        error = None
        try:
            sentence = ExampleSentence.objects.get(pk=sentence_id)
            sound_url = sentence.get_sound_url()
            
        except ExampleSentence.DoesNotExist as e:
            error = e
        if not error:
            result_list = {
                'url': sound_url,
            }
        else:
            result_list = {
                'error': 'The error is occured: {0}'.format(error),
            }
        return self.create_response(request, result_list)

    def dehydrate_categories(self, bundle):
        categories = SentenceCardList.objects.filter(owner_id=bundle.request.user.id, cards__sentence=bundle.obj)
        return [category.name for category in categories]

    def dehydrate(self, bundle):
        # bundle.data['added'] = 'Default' in bundle.data.get('categories', [])
        bundle.data['added'] = len(bundle.data.get('categories', [])) > 0
        return bundle


class PubWordResource(ModelResource):
    class Meta:
        queryset = Word.objects.all()
        authorization = ReadOnlyAuthorization()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']
        excludes = [
            'meanings',
            'pinyin_neutral',
            'taiwanese_pinyin_neutral',
            'sound_file',
        ]
        include_resource_uri = False
        cache = SimpleCache(timeout=60 * 60)

    def dehydrate_meanings_references(self, bundle):
        return bundle.obj.compiled_meanings(join=False)


class WordResource(UserLoggedIn):
    categories = fields.ToManyField(CardListResource, 'categories', null=True, readonly=True)

    class Meta:
        queryset = Word.objects.prefetch_related('references').all()
        authorization = ReadOnlyAuthorization()
        list_allowed_methods = ['get']
        detail_allowed_methods = ['get']
        excludes = [
            'meanings',
            'pinyin_neutral',
            'taiwanese_pinyin_neutral',
            'sound_file',
        ]
        include_resource_uri = False

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>{0})/search{1}".format(self._meta.resource_name, trailing_slash()),
                self.wrap_view('search'), name="api_word_search"),
            url(r"^(?P<resource_name>{0})/random{1}".format(self._meta.resource_name, trailing_slash()),
                self.wrap_view('random'), name="api_word_random"),
            url(r"^(?P<resource_name>{0})/(?P<word_id>\d+)/voice{1}".format(self._meta.resource_name, trailing_slash()),
                self.wrap_view('voice'), name="api_word_voice"),
        ]

    def voice(self, request, **kwargs):
        """
            Returns URL to mp3 sound file with the word pronounciation
        """

        self.method_check(request, allowed=['get'])
        word_id = int(kwargs['word_id'])
        error = None
        try:
            word = Word.objects.get(id=word_id)
            sound_url = word.get_sound_url()
        except Word.DoesNotExist as e:
            error = e
        if not error:
            result_list = {
                'url': sound_url,
            }
        else:
            result_list = {
                'error': 'The error is occured: {0}'.format(error),
            }
        return self.create_response(request, result_list)

    def create_response(self, request, data, response_class=HttpResponse, **response_kwargs):
        """
        Extracts the common "which-format/serialize/return-response" cycle.

        Mostly a useful shortcut/hook.
        """
        desired_format = self.determine_format(request)
        serialized = self.serialize(request, data, desired_format)
        return response_class(content=serialized, content_type=build_content_type(desired_format), **response_kwargs)

    def dehydrate_categories(self, bundle):
        nocategories = bool(int(bundle.request.GET.get('nocategories', 0)))
        if nocategories:
            return []
        else:
            cache_key = 'word_categories_{}'.format(bundle.request.user.id)
            cached_categories = cache.get(cache_key)
            if not cached_categories:
                cl = tuple(
                    CardList.objects.filter(owner_id=bundle.request.user.id).prefetch_related('cards').prefetch_related(
                        'cards__word'))
                cached_categories = tuple(
                    (category.name, tuple(card.word.id for card in category.cards.all())) for category in cl)
                cache.set(cache_key, cached_categories)
            return tuple(k for k, v in cached_categories if bundle.obj.id in v)

    def dehydrate(self, bundle):
        # bundle.data['added'] = 'Default' in bundle.data.get('categories', [])
        bundle.data['added'] = len(bundle.data.get('categories', [])) > 0
        examples_flag = bool(int(bundle.request.GET.get('examples', 0)))
        offset = bundle.request.GET.get('offset','')
        if examples_flag:
            if offset:
                example_sentences = [s.get_dictionary(bundle.obj.simplified) for s in
                                ExampleSentence.objects.search_simple(bundle.obj.simplified, offset=offset)]
            else:
                example_sentences = [s.get_dictionary(bundle.obj.simplified) for s in
                                    ExampleSentence.objects.search_simple(bundle.obj.simplified)]
            example_sentences_with_categories = []
            for sentence in example_sentences:
                sentence['categories'] = [c.name for c in
                                         SentenceCardList.objects.filter(owner_id=bundle.request.user.id,
                                                                         cards__sentence__id=int(sentence['id']))]
                example_sentences_with_categories.append(sentence)
                sentence['added'] = len(sentence['categories']) > 0
            bundle.data['exampleSentences'] = example_sentences_with_categories

        return bundle

    def _parse_chinese_query(self, query):
        query_type = '__contains'  # used in 'normal' filters
        wildcard_before = '%'  # used in 'extra' filter
        wildcard_after = '%'  # used in 'extra' filter

        if not query.startswith('*') and query.endswith('*'):
            query_type = '__startswith'
            wildcard_before = ''

        elif query.startswith('*') and not query.endswith('*'):
            query_type = '__endswith'
            wildcard_after = ''

        elif query.startswith('='):
            query_type = '__exact'

        return query.strip('*').strip('='), query_type, wildcard_before, wildcard_after

    def _parse_english_query(self, query):
        query_type = ''

        if not query.startswith('*') and query.endswith('*'):
            query_type = '__startswith'

        elif query.startswith('*') and not query.endswith('*'):
            query_type = '__endswith'

        elif query.startswith('*') and query.endswith('*'):
            query_type = '__contains'

        return query.strip('*').strip('='), query_type

    def search(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        self.is_authenticated(request)
        self.throttle_check(request)

        objects_chinese = []
        chinese_total_count = 0
        objects_english = []
        english_total_count = 0

        objects_data = {
            'chinese': objects_chinese,
            'chinese_total_count': chinese_total_count,
            'english': objects_english,
            'english_total_count': english_total_count
        }

        search_hanzis = False
        search_pinyin = False
        search_pinyin_neutral = True
        search_english = True

        query = request.GET.get('q')
        target = request.GET.get('target')  # where to search for ('chinese', 'english' and both if not provided)

        query = query.lower()
        original_query = query

        log = bool(request.GET.get('log'))
        if log:
            SearchHistoryItem.objects.create(querytext=query.strip('='))

        query, query_type_chinese, wildcard_before, wildcard_after = self._parse_chinese_query(original_query)
        query, query_type_english = self._parse_english_query(original_query)

        if query:
            query = query.replace('v', 'ü')

            ###  Determining the query type so no irrelevant fields are searched for ###

            # if query is a string of chinese characters, don't search in pinyin and english
            if zhongguolib.validators.validate_hanzis(query):
                search_hanzis = True
                search_english = search_pinyin = search_pinyin_neutral = False

            else:
                # if there are invalid syllables, assume this to be english word
                try:
                    if zhongguolib.utils.validate_pinyin(query):
                        # it's either pinyin, pinyin neutral or pinyin numbered

                        if zhongguolib.validators.validate_pinyin_characters(query):
                            # it's either pinyin, pinyin neutral
                            syllable_parts = []
                            for syllable in zhongguolib.utils.decouple_syllables(query):
                                syllable_parts.append(
                                    zhongguolib.utils.number_syllabized_pinyin(syllable, dont_number_neutral=True))
                            query = ''.join(syllable_parts)

                            search_pinyin = search_pinyin_neutral = True
                            search_hanzis = False
                            search_english = True

                            for c in original_query:  # TODO: maybe replace 'v' with 'ü'
                                # if it's a toned syllable, don't search in english
                                if c in zhongguolib.constants.ALLOWED_PININ_CHARACTERS[5:]:
                                    search_english = False
                                    break

                        else:
                            # it's numbered pinyin
                            search_pinyin = True
                            search_hanzis = search_pinyin_neutral = search_english = False

                    else:
                        # it's not hanzi nor pinyin
                        search_hanzis = search_pinyin_neutral = search_pinyin_neutral = False
                        search_english = True

                except zhongguolib.validators.InvalidSyllable as e:
                    search_english = True
                    search_hanzis = search_pinyin = search_pinyin_neutral = False

            ###  Constructing Chinese and/or English querysets ###

            queryset_chinese = Word.objects.none()
            filters = Q()

            # Prefetch object to order the references by the 'order' field
            references_prefetch = Prefetch('references__to_word',
                                           queryset=WordReference.objects.all() \
                                           # .only('pinyin')\
                                           .order_by('order'))
            # .extra(select={'order': '"{0}"."order"'.format(WordReference._meta.db_table)}))

            if (search_hanzis or search_pinyin or search_pinyin_neutral) and target != 'english':
                filter_fields = []

                if search_hanzis:
                    filter_fields += ['simplified', 'traditional'];

                if search_pinyin:
                    filter_fields += ['pinyin', 'taiwanese_pinyin'];

                if search_pinyin:
                    filter_fields += ['pinyin_neutral', 'taiwanese_pinyin_neutral'];

                for field in filter_fields:
                    filters |= Q(**{field + query_type_chinese: query})

                if filters:
                    queryset_chinese = Word.objects.prefetch_related(references_prefetch) \
                        .defer('meanings') \
                        .defer('pinyin') \
                        .defer('pinyin_neutral') \
                        .defer('taiwanese_pinyin_neutral') \
                        .extra(select={'length': 'LENGTH("simplified")'}) \
                        .order_by('length', '-frequency', 'simplified')
                    if search_hanzis and zhongguolib.constants.MIDDLE_DOT_CHARACTERS not in original_query and query_type_chinese != '__exact':
                        # if middle dot is not present in the query, and the query is not '=' exact, the user may actually be searching
                        # for entries with middle dot as well.
                        extra_query = "{0}{1}{2}".format(wildcard_before, query, wildcard_after)
                        queryset_chinese = queryset_chinese \
                            .extra(
                            where=["REPLACE(simplified, '・', '') like %s OR REPLACE(traditional, '・', '') like %s"],
                            params=[extra_query, extra_query])
                    else:
                        # if the middle dot is present, thet the user specifically serched for it,
                        # it's a normal search, no need for any further adjustments so the normal filters are applied
                        queryset_chinese = queryset_chinese.filter(filters)

            queryset_english = Word.objects.none()
            # only search english if there are at least 2 characters
            # TODO: user regex for searching in meanings
            if search_english and target != 'chinese' and len(original_query) > 1:
                query = original_query.strip('*').strip('=')

                pattern = r'\y{0}\y'.format(re.escape(query))

                if query_type_english == '__startswith':
                    pattern = r'\y{0}\y|\y{0}.*?\y'.format(re.escape(query))

                elif query_type_english == '__endswith':
                    pattern = r'\y{0}\y|\y.*?{0}\y'.format(re.escape(query))

                elif query_type_english == '__contains':
                    pattern = r'\y{0}\y|\y.*?{0}.*?\y'.format(re.escape(query))

                queryset_english = Word.objects.prefetch_related(references_prefetch) \
                    .filter(Q(meanings__iregex=pattern)) \
                    .defer('meanings') \
                    .defer('pinyin') \
                    .defer('pinyin_neutral') \
                    .defer('taiwanese_pinyin_neutral') \
                    .extra(select={'length': 'LENGTH("simplified")'}) \
                    .order_by('length', '-frequency', 'simplified')

            # Paginating results (this is where the querysets are evaluated (SQL queries issued)) #

            per_page = 10
            page = int(request.GET.get('page', 0)) + 1

            paginator_chinese = Paginator(queryset_chinese, per_page)
            paginator_english = Paginator(queryset_english, per_page)

            try:
                page_chinese = paginator_chinese.page(page)
                object_list_chinese = page_chinese.object_list
            except InvalidPage:
                object_list_chinese = []

            try:
                page_english = paginator_english.page(page)
                object_list_english = page_english.object_list
            except InvalidPage:
                object_list_english = []

            # for word in page.object_list:
            for word in object_list_chinese:
                bundle = self.build_bundle(obj=word, request=request)
                bundle = self.full_dehydrate(bundle)
                objects_chinese.append(bundle)

            for word in object_list_english:
                bundle = self.build_bundle(obj=word, request=request)
                bundle = self.full_dehydrate(bundle)
                objects_english.append(bundle)

            pinyin_sorted_meaning_reference = [
                {'pinyin': word.pinyin_normalized, 'meanings': word.compiled_meanings(join=False)} for word in
                object_list_chinese]

            chinese_total_count = paginator_chinese.count
            english_total_count = paginator_english.count

            objects_data = {
                'chinese': objects_chinese,
                'chinese_total_count': chinese_total_count,
                'english': objects_english,
                'english_total_count': english_total_count,
                'pinyin_sorted_meaning_reference': pinyin_sorted_meaning_reference,
            }

        if original_query:
            Search.objects.create(text=original_query.strip('='))
        return self.create_response(request, objects_data)

    def random(self, request, **kwargs):
        self.throttle_check(request)
        self.method_check(request, ['get'])

        all_words_ids = Word.objects.values_list('id', flat=True)

        words_random = Word.objects.filter(id__in=random.sample(list(all_words_ids), 7))

        return self.create_response(request, [
            {'id': word.id, 'simplified': word.simplified} for word in words_random
        ])


    def dehydrate_taiwanese_pinyin(self, bundle):
        try:
            taiwanese_pinyin = bundle.data['taiwanese_pinyin']
            if taiwanese_pinyin:
                return zhongguolib.utils.syllabize_numbered_pinyin(taiwanese_pinyin.replace(' ', '').lower())
            return ""
        except zhongguolib.validators.InvalidSyllable as e:
            return ""

    def dehydrate_meanings_references(self, bundle):
        return bundle.obj.compiled_meanings(join=False)


# class PageNumberPaginator(Paginator):
#     def page(self):
#         output = super(PageNumberPaginator, self).page()
#         output['page_number'] = int(self.offset / self.limit) + 1
#         return output

class LessonResource(UserLoggedIn):
    # TODO: optimize response size
    class Meta:
        limit = Lesson.objects.all().count()
        queryset = Lesson.objects.all().order_by('number')
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        max_limit = 1000
        # cache = SimpleCache(timeout=60*60)

    def dehydrate(self, bundle):
        u = User.objects.get(username=bundle.request.user)
        bundle.data['lesson_completed'] = bundle.data['number'] in [l.number for l in u.lessons_completed.all()]
        words = json.loads(bundle.data['new_words_converted'])
        result = []
        for word in words:
            categories = CardList.objects.filter(owner_id=bundle.request.user.id, cards__word=word['id'])
            word['added'] = len(categories) > 0
            word['categories'] = [category.name for category in categories]
            word['meanings_references'] = Word.objects.get(id=word['id']).compiled_meanings(join=False)
            result.append(word)
        bundle.data['new_words'] = result
        bundle.data['new_words_count'] = len(words)
        return bundle

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/(?P<lesson_number>\d+)/switch_learned_status%s$" % (
                self._meta.resource_name, trailing_slash()), self.wrap_view('switch_learned_status'),
                name="api_lesson_switch_learned_status"),
            url(r"^(?P<resource_name>%s)/(?P<lesson_number>\d+)/complete%s$" % (
                self._meta.resource_name, trailing_slash()), self.wrap_view('complete'),
                name="api_lesson_complete"),
            url(r"^(?P<resource_name>{0})/test{1}".format(self._meta.resource_name, trailing_slash()),
                self.wrap_view('test_sentry'), name="api_lesson_test_sentry"),
            url(r"^(?P<resource_name>{0})/popular{1}".format(self._meta.resource_name, trailing_slash()),
                self.wrap_view('popular'), name="api_lesson_popular"),
            url(r"^(?P<resource_name>%s)/(?P<number>\d+)/$" % self._meta.resource_name,
                self.wrap_view('dispatch_detail'), name="api_dispatch_detail"),
        ]

    def test_sentry(self, request, **kwargs):
        """
            This is only test for Sentry
        """

        int('throw an exception')
        return self.create_response(request, {'error': 'you shouldn\'t see that'})

    def switch_learned_status(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        self.is_authenticated(request)
        lesson_number = int(kwargs['lesson_number'])
        u = User.objects.get(username=request.user)
        if lesson_number in [l.number for l in u.lessons_completed.all()]:
            u.lessons_completed.remove(Lesson.objects.get(number=lesson_number))
        else:
            u.lessons_completed.add(Lesson.objects.get(number=lesson_number))

        result_list = {
            'success': True,
        }

        return self.create_response(request, result_list)

    def complete(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        self.is_authenticated(request)
        lesson_number = int(kwargs['lesson_number'])
        u = User.objects.get(username=request.user)
        if lesson_number in [l.number for l in u.lessons_completed.all()]:
            pass
        else:
            u.lessons_completed.add(Lesson.objects.get(number=lesson_number))

        result_list = {
            'success': True,
        }

        return self.create_response(request, result_list)

    #NEW
    def get_list(self, request, **kwargs):
        base_bundle = self.build_bundle(request=request)

        objects = self.cached_obj_get_list(bundle=base_bundle, **self.remove_api_resource_names(kwargs))

        sorted_objects = self.apply_sorting(objects, options=request.GET)

        paginator = self._meta.paginator_class(request.GET, sorted_objects, resource_uri=self.get_resource_uri(),
                                               limit=self._meta.limit, max_limit=self._meta.max_limit,
                                               collection_name=self._meta.collection_name)
        to_be_serialized = paginator.page()

        # Dehydrate the bundles in preparation for serialization.
        bundles = []

        for obj in to_be_serialized[self._meta.collection_name]:
            bundle = self.build_bundle(obj=obj, request=request)
            bundles.append(self.full_dehydrate(bundle, for_list=True))

        to_be_serialized[self._meta.collection_name] = bundles
        to_be_serialized = self.alter_list_data_to_serialize(request, to_be_serialized)

        return self.create_response(request, to_be_serialized)


    def popular(self, request, **kwargs):
        return self.get_list(request)


class StudyContentResource(ModelResource):
    # TODO: optimize response size
    class Meta:
        limit = 0
        queryset = StudyContent.objects.all().order_by('number')
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        detail_uri_name = 'number'
        cache = SimpleCache(timeout=60 * 60)

    def prepend_urls(self):
        return [
            url(r"^random_titles%s$" % (trailing_slash()), self.wrap_view('random_titles'),
                name="api_content_random_titles"),
        ]

    def random_titles(self, request, **kwargs):

        # self.is_authenticated(request)
        RANDOM_TITLES_AMOUNT = 7

        self.throttle_check(request)
        self.method_check(request, ['get'])

        offset = random.randint(1, 3)
        start = random.randint(1, 3)

        text = StudyContent.objects.all()[start::offset]
        audio = AudioStudyItem.objects.all()[start::offset]
        video = VideoStudyItem.objects.all()[start::offset]

        text_data = [{'type': 'text', 'name': obj.english_name, 'id': obj.id} for obj in text]
        video_data = [{'type': 'video', 'name': obj.name, 'id': obj.id} for obj in video]
        audio_data = [{'type': 'audio', 'name': obj.name, 'id': obj.id} for obj in audio]

        mix = list(text_data) + list(video_data) + list(audio_data)
        mix = mix[0:RANDOM_TITLES_AMOUNT]
        return self.create_response(request, mix)


class VideoStudyItemResource(ModelResource):
    class Meta:
        limit = 0
        queryset = VideoStudyItem.objects.all()
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        include_resource_uri = False
        cache = SimpleCache(timeout=60 * 60)
        resource_name = 'videostudyitem'

    def full_dehydrate(self, bundle, *args, **kwargs):
        for_list = kwargs.get('for_list', None)
        if for_list:
            del (bundle.obj.srt)
        return super().full_dehydrate(bundle, *args, **kwargs)


class AudioStudyItemResource(ModelResource):
    class Meta:
        limit = 0
        queryset = AudioStudyItem.objects.all()
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        include_resource_uri = False
        cache = SimpleCache(timeout=60 * 60)
        resource_name = 'audiostudyitem'
        filtering = {
            'study_level': ALL,
            'themes': ALL,
        }

    def full_dehydrate(self, bundle, *args, **kwargs):
        for_list = kwargs.get('for_list', None)
        if for_list:
            del (bundle.obj.srt)
        return super().full_dehydrate(bundle, *args, **kwargs)

class ChineseNameResourse(ModelResource):
    class Meta:
        queryset = ChineseName.objects.all()
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        resource_name = 'chinesenames'


class SuggestWordResourse(UserLoggedIn):
    class Meta:
        queryset = SuggestWord.objects.all()
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        resource_name = 'suggestwords'

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/add%s$" % (self._meta.resource_name, trailing_slash()),
                self.wrap_view('suggestword_add'), name="api_suggestword_adds"),
        ]

    def suggestword_add(self, request, **kwargs):
        SessionAuthentication().is_authenticated(request)
        if not request.user.id:
            return http.HttpUnauthorized()

        self.throttle_check(request)
        self.method_check(request, ['post'])

        deserialized = self.deserialize(request, request.body,
                                        format=request.META.get('CONTENT_TYPE', 'application/json'))
        deserialized = self.alter_deserialized_detail_data(request, deserialized)

        # sentence_id = deserialized.get('sentence_id')
        chinese = deserialized.get('chinese')
        english = deserialized.get('english')
        pinyin = deserialized.get('pinyin')

        if not chinese or not english:
            return http.HttpBadRequest('Fields "chinese" and "english" is empty!')

        word = SuggestWord.objects.create(
            english=english,
            chinese=chinese,
            pinyin=pinyin
        )
        return http.HttpCreated()
	
    # 10-02-2018 by akriti	
class WordOfTheDayResourse(ModelResource):
    class Meta:
        authorization = DjangoAuthorization()
        # now = datetime.datetime.today()
        # earlier = now - datetime.timedelta(days=4)
        # filter(creation_date__range=(earlier,now))
        queryset = WordOfTheDay.objects.all().order_by('-creation_date')[:5]
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        include_resource_uri = False
        resource_name = 'wordoftheday'
        
    def dehydrate_creation_date(self, bundle):
        return bundle.obj.creation_date.strftime("%d %b")

class FeaturedContentResourse(ModelResource):
    content = fields.ForeignKey(AudioStudyItemResource,'content')
    class Meta:
        authorization = DjangoAuthorization()
        queryset = FeaturedContent.objects.all().order_by('-creation_date')[:3]
        detail_allowed_methods = ['get']
        list_allowed_methods = ['get']
        include_resource_uri = False
        resource_name = 'featuredcontent'	
    
    def dehydrate_content(self, bundle):
        return bundle.obj.content.id