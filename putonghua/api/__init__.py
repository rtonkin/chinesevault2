from tastypie.api import Api
from putonghua.api.resources import (
	UserResource,
    SearchResource,
    WordResource,
    UserCardResource,
    CardListResource,
    CountryResource,
    PubCardListResource,
    LessonResource,
    StudyContentResource,
    UserSentenceCardResource,
    SentenceCardListResource,
    SentenceResource,
    VideoStudyItemResource,
    AudioStudyItemResource,
    ChineseNameResourse,
    SuggestWordResourse,
	WordOfTheDayResourse,
    FeaturedContentResourse
)

api = Api(api_name='1.0')
api.register(UserResource())
api.register(CountryResource())
api.register(SearchResource())
api.register(WordResource())
api.register(UserCardResource())
api.register(CardListResource())
api.register(PubCardListResource())
api.register(LessonResource())
api.register(StudyContentResource())
api.register(UserSentenceCardResource())
api.register(SentenceCardListResource())
api.register(SentenceResource())
api.register(VideoStudyItemResource())
api.register(AudioStudyItemResource())
api.register(ChineseNameResourse())
api.register(SuggestWordResourse())
api.register(WordOfTheDayResourse())
api.register(FeaturedContentResourse())