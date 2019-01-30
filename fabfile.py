"""
    fabfile.py - used with fab utility
"""
from __future__ import with_statement
from fabric.api import env, cd, prefix, run, sudo, task, local
from fabric import colors
from fabric.context_managers import shell_env
from contextlib import contextmanager as _contextmanager


env.hosts = ['46.101.241.36:22']
env.user = 'phua'
#env.directory = '/home/phua/putonghua-social/env/'
env.directory = '/home/phua/chinesevault/env/'
#env.activate = 'source /home/phua/putonghua-social/env/bin/activate'
env.activate = 'source /home/phua/chinesevault/env/bin/activate'
env.shell_env = {
                'DATABASE_URL':'postgres://phua:hEmu5hatedRed6es@localhost/phua',
                'DJANGO_SETTINGS_MODULE':'putonghua.settings.production'
                }

@_contextmanager
def virtualenv():
    """Use virtualenv path as contextmanager

    """
    with prefix(env.activate):
        yield

@task
def deploy():
    """Deploy project to remote server

    """
    local('git push')
    #with cd('/home/phua/putonghua-social/'):
    with cd('/home/phua/chinesevault/'):
        print colors.cyan('Pulling changes...')
        run('git pull  --no-edit')
        with virtualenv():
            run('pwd')
            run('pip install -r requirements.txt')
            run('python manage.py makemigrations')
            run('python manage.py migrate --noinput')
            run('python manage.py collectstatic --noinput')
            run('cp -r frontend/dist/css staticfiles/')
            run('cp -r frontend/dist/js staticfiles/')
            run('cp -r frontend/dist/images staticfiles/')
            run('cp -r frontend/dist/templates staticfiles/')
            run('cp -r frontend/dist/fonts staticfiles/')
            run('cp frontend/dist/*.* staticfiles/')
            run('find staticfiles/ -name "*.gz" -type f -delete')
            run('gzip -9kr staticfiles/')
            #run('./deploy_chinesevault.sh')
            run('touch touchreload')

@task
def migrate():
    """Migrate remote db

    """
    run('python manage.py migrate --noinput')

@task
def lmigrate():
    """Migrate local db

    """
    local('python manage.py makemigrations --noinput')
    local('python manage.py migrate --noinput')

@task
def push():
    """
        Push to repo

    """
    print colors.cyan('Pushing to repo...')
    local('git push')

@task
def freeze():
    """
        Freeze pip requirements

    """
    print colors.cyan('Freezing pip requirements...')
    local('pip freeze > requirements/base.txt')
    local('git add requirements/base.txt')
    local('git commit -m "New requirements freeze"')
