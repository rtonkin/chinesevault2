#!/bin/sh
cd /home/phua/
rm -rf chinesevault/
rsync -av --progress putonghua-social/ chinesevault/ --exclude .git/--exclude media/
ln -s /home/phua/chinesevault/media/ /home/phua/putonghua-social/media
echo "DONT FORGET TO FIX GOOGLE  in frontend/src/base.html !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
exit

"""

<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-8244048-18', 'auto');
  ga('send', 'pageview');

</script>

BACKUP
tar cf - putonghua-social/ -P | pv -s $(du -sb putonghua-social/ | awk '{print $1}') | gzip > backup-12.03.2016.tar.gz


"""
