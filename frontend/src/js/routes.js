angular.module('putonghua')
    .config(function ($stateProvider, $urlRouterProvider, AppConfig) {
            $urlRouterProvider.otherwise(function($injector, $location){
               var state = $injector.get('$state');
               state.go('404');
               return $location.path();
            });
            // fix for trailing slash
              $urlRouterProvider.rule(function($injector, $location) {

                var path = $location.path();
                var hasTrailingSlash = path[path.length-1] === '/';
                if(hasTrailingSlash) {

                  //if last charcter is a slash, return the same url without the slash
                  return path.substr(0, path.length - 1);
                }

              });
            var tmpltUrl = '/static/templates/'
            $stateProvider
                .state('404', {
                    // no url defined
                    templateUrl: tmpltUrl+'staticContent/404.html',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('home', {
                    url: '/',
                    templateUrl: tmpltUrl+'homePage/home.html',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'ChineseVault.com – Free Chinese Dictionary, Flashcards, Lessons and more',
                        description: 'With a free Chinese / English dictionary, Chinese lessons, flashcards,  audio study content, as well as text analysis tools, we have everything you need to master the Chinese language.',
                        keywords: 'free chinese dictionary, free chinese lessons, chinese flashcards, chinese study content, chinese tools'
                    }
                })
                .state('dictionary', {
                    url: '/dictionary?q',
                    templateUrl: tmpltUrl+'dictionary/dictionary.html',
                    reloadOnSearch: false,
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Free Chinese / English Dictionary - ChineseVault.com',
                        description: 'Completely free Chinese / English dictionary with over 100,000 entries and full audio. Search in Chinese, English or Pinyin, and see example sentences.',
                        keywords: 'chinese english dictionary, free chinese dictionary, online dictionary, chinese definitions, chinese characters'
                    }
                })
                .state('suggest_word', {
                    url: '/suggest_word',
                    templateUrl: tmpltUrl+'dictionary/suggest_word.html',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Free Chinese / English Dictionary - ChineseVault.com',
                        description: 'Completely free Chinese / English dictionary with over 100,000 entries and full audio. Search in Chinese, English or Pinyin, and see example sentences.',
                        keywords: 'chinese english dictionary, free chinese dictionary, online dictionary, chinese definitions, chinese characters'
                    }
                })
                .state('flashcards', {
                    url: '/flashcards',
                    templateUrl: tmpltUrl+'practiceWords/practice.html',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Flashcards – ChineseVault.com',
                        description: 'Free online flashcard app to help to learn mandarin Chinese. Existing flashcard lists including HSK are ready to study now. Don’t forget what you learn!',
                        keywords: 'chinese flashcards, memorize chinese, chinese practice, online flashcards, practice characters, free chinese flashcards'
                    }

                })
                .state('texttool', {
                    url: '/texttool',
                    templateUrl: tmpltUrl+'textTool/texttool.html',
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Text Reader – ChineseVault.com',
                        description: 'Learn to read and understand Chinese with our Text Tool. Click on any Chinese word for a full definition, instantly add Pinyin to Chinese text, or convert from simplified to traditional characters.',
                        keywords: 'analyze chinese, add pinyin, convert pinyin, simplified to traditional, chinese text tools'
                    }
                })
                .state('lesson', {
                    url: '/lesson',
                    templateUrl: tmpltUrl+'lessons/lessons.html',
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Free Chinese Lessons – ChineseVault.com',
                        description: 'A series of over 30 completely free Chinese lessons for beginners. Learn the basic vocabulary and sentence structures to get you speaking basic Chinese in no time.',
                        keywords: 'free chinese lessons, online chinese lessons, free chinese, mandarin lessons, free mandarin lessons, learn chinese'
                    }
                })
                .state('lesson_detail', {
                    url: '/lesson/:lessonNumber',
                    templateUrl: tmpltUrl+'lessons/lesson_detail.html',
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        keywords: 'free chinese lessons, online chinese lessons, free chinese, mandarin lessons, free mandarin lessons, learn chinese'
                    }
                })
                .state('study_content_list', {
                    url: '/studycontent',
                    templateUrl: tmpltUrl+'studyContent/study_content_list.html',
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Study Content – ChineseVault.com',
                        description: 'Learn Chinese with real study content. Find Text, Audio and Video for listening and reading practice and teach yourself with our advanced',
                        keywords: 'chinese study content, learn chinese, chinese audio, chinese text, learn to read chinese'
                    }
                })
                .state('study_content_audio_list', {
                    url: '/studycontent/audio',
                    templateUrl: tmpltUrl+'studyContent/study_subtitle_audio_list.html',
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Audio Study Content – ChineseVault.com',
                        description: 'Learn Chinese with real audio study content. Improve your listening and reading skills by listening to real Chinese audio, with a complete transcript to help you learn.',
                        keywords: 'chinese audio study content, learn chinese with audio, learn chinese free, chinese audio'
                    }
                })
                .state('study_content_audio_item', {
                    url: '/studycontent/audio/:id',
                    templateUrl: tmpltUrl+'studyContent/study_subtitle_detail.html',
                    requireLogin: true,
                    requireSubscription: true,
                    params: { id: localStorage.getItem('s_page_id') },
                    controller: function($scope, $stateParams) {
                      $scope.contentType = 'audio';
                      $scope.itemNumber = $stateParams.id;
                    },
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        keywords: 'chinese audio study content, learn chinese with audio, learn chinese free, chinese audio'
                    }                    
                })
                /*.state('study_content_audio_list', { //if you want to show video = study_content_video_list
                    url: '/studycontent/audio', // = /studycontent/video
                    templateUrl: tmpltUrl+'studyContent/study_subtitle_audio_list.html',//tmpltUrl+'studyContent/study_subtitle_video_list.html'
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Video Study Content – ChineseVault.com',
                        description: 'Learn Chinese with real video study content. Improve your listening and reading skills by watching real Chinese videos, with a complete transcript to help you learn.',
                        keywords: 'chinese video study content, learn chinese with videos, learn chinese free, chinese videos'
                    }
                })
                .state('study_content_video_item', {
                    url: '/studycontent/video/:id',
                    templateUrl: tmpltUrl+'studyContent/study_subtitle_detail.html',
                    requireLogin: true,
                    requireSubscription: true,
                    controller: function($scope, $stateParams) {
                      $scope.contentType = 'video';
                      $scope.itemNumber = $stateParams.id;
                    },
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        keywords: 'chinese video study content, learn chinese with videos, learn chinese free, chinese videos'
                    }
                })*/
                .state('study_content_text_list', {
                    url: '/studycontent/text',
                    templateUrl: tmpltUrl+'studyContent/study_content_text_list.html',
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Text Study Content – ChineseVault.com',
                        description: 'Learn Chinese with real text study content. Improve your reading skills by reading real Chinese stories, news, songs and poems, with a complete transcript to help you learn.',
                        keywords: 'chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs'
                    }
                })
                .state('study_content_text_item', {
                    url: '/studycontent/text/:id',
                    templateUrl: tmpltUrl+'studyContent/study_content_text_detail.html',
                    requireLogin: false,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        keywords: 'chinese text study content, learn chinese by reading, learn chinese free, chinese text, chinese poems, chinese news, chinese songs'
                    }
                })
                .state('word', {
                    url: '/word/:wordId',
                    templateUrl: tmpltUrl+'dictionary/word_detail.html',
                    resolve: {
                        init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {                       
                        keywords: 'chinese definitions, English chinese dictionary, chinese example sentences, chinese audio'
                    }
                })
                .state('arrange-cards', {
                    url: '/arrange-cards',
                    templateUrl: tmpltUrl+'practiceWords/arrange_cards.html',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('test-settings', {
                    url: '/test-settings',
                    templateUrl: tmpltUrl+'practiceWords/test_settings.html',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('arrange-cards-sentences', {
                    url: '/arrange-cards-sentences',
                    templateUrl: tmpltUrl+'practiceSentences/arrange_cards_sentences.html',
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('test-settings-sentences', {
                    url: '/test-settings-sentences',
                    templateUrl: tmpltUrl+'practiceSentences/test_settings_sentences.html',
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('test', {
                    url: '/test?quick',
                    templateUrl: tmpltUrl+'practiceWords/test.html',
                    controller: 'TestController',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('test-sentences', {
                    url: '/test-sentences',
                    templateUrl: tmpltUrl+'practiceSentences/test-sentences.html',
                    controller: 'TestSentencesController',
                    requireLogin: true,
                    requireSubscription: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Practice Sentences'
                    }
                })
                .state('profile', {
                    url: '/profile',
                    templateUrl: tmpltUrl+'users/profile.html',
                    controller: 'ProfileController',
                    requireLogin: true,
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'User Profile'
                    }
                })

                // static templates without controllers
                .state('about', {
                    url: '/about',
                    templateUrl: tmpltUrl+'staticContent/about.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'About Chinese Vault'
                    }
                })
                .state('terms-of-use', {
                    url: '/terms-of-use',
                    templateUrl: tmpltUrl+'staticContent/terms_of_use.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Terms of Use'
                    }
                })
                .state('privacy-policy', {
                    url: '/privacy-policy',
                    templateUrl: tmpltUrl+'staticContent/privacy_policy.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Privacy Policy'
                    }
                })
               /* .state('advertise', {
                    url: '/advertise',
                    templateUrl: tmpltUrl+'staticContent/advertise.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                }) */
                .state('contact', {
                    url: '/contact',
                    templateUrl: tmpltUrl+'users/contact.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Contact Chinese Vault'
                    }
                })
                .state('resources_pinyin_chart', {
                    url: '/pinyin_chart',
                    templateUrl: tmpltUrl+'staticContent/pinyin_chart.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Free Pinyin Chart with Audio – ChineseVault.com',
                        description: 'Free Chinese Pinyin chart containing all 1,300+ pinyin sounds, with audio for every sound. Practice your pronunciation today.',
                        keywords: 'free pinyin chart, chinese pinyin chart, pinyin audio, pinyin chart with audio, pinyin explanation'
                    }
                })
                .state('resources_char_freq', {
                    url: '/char_freq',
                    templateUrl: tmpltUrl+'staticContent/char_freq.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Simplified Chinese Character Frequency List – ChineseVault.com',
                        description: 'Chart containing the most common 5,000 characters sorted by frequency. Test your character knowledge and find new characters to learn.',
                        keywords: 'chinese character frequency, chinese character frequency chart,'
                    }
                })
                .state('resources_word_freq', {
                    url: '/word_freq',
                    templateUrl: tmpltUrl+'staticContent/word_freq.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Word Frequency List – ChineseVault.com',
                        description: 'Chart containing the most common 20,000 Chinese words sorted by frequency. Test your word knowledge and find new words to learn.',
                        keywords: 'chinese word frequency, chinese word frequency chart'
                    }
                })
                .state('resources_word_chart', {
                    url: '/measure_word_chart',
                    templateUrl: tmpltUrl+'staticContent/word_chart.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Measure Word List – ChineseVault.com',
                        description: 'List containing hundreds of Chinese Measure words sorted from beginner to expert. Brush up on your measure words today.',
                        keywords: 'chinese measure words, chinese measure word chart, chinese counter words, chinese counter words chart'
                    }
                })
                .state('resources_names', {
                    url: '/names',
                    templateUrl: tmpltUrl+'staticContent/word_name.html',
                    controller: 'StaticController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Chinese Measure Word List – ChineseVault.com',
                        description: 'List containing hundreds of Chinese Measure words sorted from beginner to expert. Brush up on your measure words today.',
                        keywords: 'chinese measure words, chinese measure word chart, chinese counter words, chinese counter words chart'
                    }
                })
                .state('pinyintool', {
                    url: '/pinyintool',
                    templateUrl: tmpltUrl+'staticContent/pinyintool.html',
                    controller: 'PinyintoolController',
                    metaTags: {
                        title: 'Pinyin Keyboard',
                        description: 'Type pinyin online with this simple tool.',
                        keywords: 'pinyin keyboard, pinyin'
                    }
                })
                // signup/login/password views (userena views)
                .state('signup', {
                    url: '/signup?email',
                    templateUrl: tmpltUrl+'users/signup_form.html',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Signup'
                    }
                })
                .state('login', {
                    url: '/login?:nextState&:forceLogout',
                    templateUrl: tmpltUrl+'users/login.html',
                    controller: 'LoginController',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Login'
                    }
                })
                // subscribe views
                .state('paidonly', {
                    url: '/paidonly?:nextState',
                    templateUrl: tmpltUrl+'users/paidonly.html',
                    params: {hideSorry: false},
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Paid Only'
                    }
                })
                .state('checkout', {
                    url: '/checkout?:nextState',
                    templateUrl: tmpltUrl+'users/checkout.html',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Checkout'
                    }
                })
                .state('userSuccessSignup', {
                    url: '/signup/success',
                    template: '<user-success-signup></user-success-signup>',
                    params: {userData:null},
                })
                .state('paymentsConfirmUnsubscribe', {
                    url: '/payments/confirm_unsubscribe',
                    template: '<payments-confirm-unsubscribe></payments-confirm-unsubscribe>',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('paymentsUnsubscribeFeedback', {
                    url: '/payments/unsubscribe_feedback',
                    template: '<payments_unsubscribe_feedback></payments_unsubscribe_feedback>',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    }
                })
                .state('paymentsCancellation', {
                    url: '/payments/cancellation',
                    template: '<payments_cancellation></payments_cancellation>',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Payments Cancellation'
                    }
                })
                .state('forgottenPassword', {
                    url: '/accounts/password/reset',
                    templateUrl: tmpltUrl+'dialogs/forgotten_password.html',
                    resolve: {
                       init: function(Auth) {
                            return Auth.updateUser();
                        }
                    },
                    metaTags: {
                        title: 'Forgot Password'
                    }
                })
        }
    )
;
