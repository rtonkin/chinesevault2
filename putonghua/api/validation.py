from django import forms
from django.conf import settings
from django.contrib.auth import authenticate, login
from userena.utils import (signin_redirect, get_profile_model, get_user_model,
                           get_user_profile)
from userena import settings as userena_settings
from userena.models import UserenaSignup
from userena import settings as userena_settings
from putonghua.core.models import Country
import sys
attrs_dict = {'class': 'required'}

def get_country_choices():
    return [(country.id, country.name) for country in Country.objects.all()]


class ExtendedSignupForm(forms.Form):
    """
    Form for creating a new user account.

    Validates that the requested username and e-mail is not already in use.
    Also requires the password to be entered twice.

    """
    CHINESE_LEVEL_CHOICES = (
        ('Beginner', 'Beginner'),
        ('Intermediate', 'Intermediate'),
        ('Advanced', 'Advanced'),
    )

    username = forms.RegexField(regex=settings.USERNAME_VALIDATION_PATTERN,
                                min_length=4,
                                max_length=64,
                                widget=forms.TextInput(attrs=attrs_dict),
                                label="Username",
                                error_messages={
                                    'invalid': 'Username may contain only letters, numbers, dots, and underscores. Other characters are prohibited.'
                                })
    email = forms.EmailField(widget=forms.TextInput(attrs=dict(attrs_dict,
                                                               maxlength=75)),
                             label="Email")
    password1 = forms.CharField(widget=forms.PasswordInput(attrs=attrs_dict,
                                                           render_value=False),
                                label="Create password")
    password2 = forms.CharField(widget=forms.PasswordInput(attrs=attrs_dict,
                                                           render_value=False),
                                label="Repeat password")

    location = forms.ChoiceField(label='Location', required=False, choices=get_country_choices)

    chinese_level = forms.ChoiceField(label='Chinese Level', required=False, choices=CHINESE_LEVEL_CHOICES)

    def clean_location(self):
        try:
            self.cleaned_data['location'] = Country.objects.get(id=self.cleaned_data.get('location', 0))
        except (ValueError, Country.DoesNotExist) as e:
            self.cleaned_data['location'] = None

        return self.cleaned_data['location']

    def clean_chinese_level(self):
        if (self.cleaned_data.get('chinese_level', '')
                not in [choice[0] for choice in self.CHINESE_LEVEL_CHOICES]):
            self.cleaned_data['chinese_level'] = ''

        return self.cleaned_data['chinese_level']

    def clean_username(self):
        """
        Validate that the username is alphanumeric and is not already in use.
        Also validates that the username is not listed in
        ``USERENA_FORBIDDEN_USERNAMES`` list.
        """
        try:
            user = get_user_model().objects.get(username__iexact=self.cleaned_data['username'])
        except get_user_model().DoesNotExist:
            pass
        else:
            # if userena_settings.USERENA_ACTIVATION_REQUIRED and UserenaSignup.objects.filter(user__username__iexact=self.cleaned_data['username']).exclude(activation_key=userena_settings.USERENA_ACTIVATED):
            #    raise forms.ValidationError('This username is already taken but not confirmed. Please check your email for verification steps.')
            raise forms.ValidationError('This username is already taken.')
        if self.cleaned_data['username'].lower() in userena_settings.USERENA_FORBIDDEN_USERNAMES:
            raise forms.ValidationError('This username is not allowed. Please choose another one.')

        return self.cleaned_data['username']

    def clean_email(self):
        """ Validate that the e-mail address is unique. """
        if get_user_model().objects.filter(email__iexact=self.cleaned_data['email']):
            #if userena_settings.USERENA_ACTIVATION_REQUIRED and UserenaSignup.objects.filter(user__email__iexact=self.cleaned_data['email']).exclude(activation_key=userena_settings.USERENA_ACTIVATED):
            #    raise forms.ValidationError('This email is already in use but not confirmed. Please check your email for verification steps.')
            raise forms.ValidationError('This email is already in use. Please supply a different email.')

        return self.cleaned_data['email']

    def clean(self):
        """
        Validates that the values entered into the two password fields match.
        Note that an error here will end up in ``non_field_errors()`` because
        it doesn't apply to a single field.
        """

        if 'password1' in self.cleaned_data and 'password2' in self.cleaned_data:
            if self.cleaned_data['password1'] != self.cleaned_data['password2']:
                raise forms.ValidationError('The two password fields didn\'t match.')

        return self.cleaned_data

    def save(self):
        """ Creates a new user and account. Returns the newly created user. """
        username, email, password = (self.cleaned_data['username'],
                                     self.cleaned_data['email'],
                                     self.cleaned_data['password1'])
        print('activation required',  userena_settings.USERENA_ACTIVATION_REQUIRED)
        try:
            new_user = UserenaSignup.objects.create_user(
                username,
                email,
                password,
                not userena_settings.USERENA_ACTIVATION_REQUIRED,
                userena_settings.USERENA_ACTIVATION_REQUIRED
            )
        except:
            print(sys.exc_info())
        print('new user', new_user.is_active)
        # only save the user again if any of location and chinese level fields have values
        if self.cleaned_data['location'] or self.cleaned_data['chinese_level']:
            new_user.location = self.cleaned_data['location']
            new_user.chinese_level = self.cleaned_data['chinese_level']
            new_user.save()
        print('new user', new_user.is_active)
        return new_user


class AuthenticationForm(forms.Form):
    """
    A custom form where the identification can be a e-mail address or username.
    """
    identification = forms.CharField(label="Email or username",
                                     required=True,
                                     widget=forms.TextInput(attrs=attrs_dict),
                                     max_length=75,
                                     error_messages={'required': "Either supply us with your email or username."})

    password = forms.CharField(label="Password",
                               required=True,
                               widget=forms.PasswordInput(attrs=attrs_dict, render_value=False))

    """
    remember_me = forms.BooleanField(widget=forms.CheckboxInput(),
                                     required=False,
                                     label='Remember me for %(days)s' % {'days': userena_settings.USERENA_REMEMBER_ME_DAYS[0]})
    """

    #def __init__(self, *args, **kwargs):
    #    """ A custom init because we need to change the label if no usernames is used """
    #    super(AuthenticationForm, self).__init__(*args, **kwargs)

        # self.fields['remember_me'].label = 'Remember me for %(days)s' % {'days': userena_settings.USERENA_REMEMBER_ME_DAYS[0]}

        # if userena_settings.USERENA_WITHOUT_USERNAMES:
        #    self.fields['identification'] = identification_field_factory("Email",
        #                                                                 "Please supply your email.")

    def clean(self):
        """
        Checks for the identification and password.
        If the combination can't be found will raise an invalid sign in error.
        """
        identification = self.cleaned_data.get('identification')
        password = self.cleaned_data.get('password')

        if identification and password:
            user = authenticate(identification=identification, password=password)

            if user is None:
                raise forms.ValidationError("Please enter a correct username or email and password. Note that both fields are case-sensitive.")

        return self.cleaned_data
