# H3 Github tehtävä
Tein tehtävän Xubuntu 18.04.1 live-usb tikulla su klo 20 eteenpäin.
Pohjustin tehtävää asentamalla salt -masterin ja -minion ja tein 'otso' orjan aiempien tehtävien mukaan. En tehnyt /srv/salt -kansiota, koska kloonaan sen githubista(salt -repository). Käytin tehtävän tekoon Teri Karvisen ohjeita sivulla: http://terokarvinen.com/2016/publish-your-project-with-github


### c) _Laita /srv/salt/ gittiin. Tee uusi moduli. Kloonaa varastosi toiselle koneelle (tai poista /srv/salt ja palauta se kloonaamalla) ja jatka sillä._

Aloitin asentamalla gitin komennoilla:
 - sudo apt-get update
 - sudo apt-get install -y git
 
Tein kokeeksi kotihakemistoon Git repon komennolla:
 - git init Git

Tämän jälkeen menin siihen /Git ja tein README.md tiedoston, jonka jälkeen tein komennot:
 - git add .
 - git commit

Tässä kohtaa git kysyi kuka olen ja asetin omat käyttäjätietoni komennoilla:
 - git config --global user.email "otsorauta@hotmail.com"
 - git config --global user.name "Otso Rauta"
 
Sitten tein viel committin uudestaan johon kirjoitin vain _This is a Git install README_
Jonka jälkeen git log näytti seuraavan:

 > xubuntu@xubuntu:~/Git$ git log
commit 564117e99b84585337ebce033d24b061a91bdb8d (HEAD -> master)
Author: Otso Rauta <otsorauta@hotmail.com>
Date:   Sun Nov 11 20:49:12 2018 +0000
>
   > This is a  Git install README

   
#### Kloonaaminen salt-repo gitistä srv/ kansioon

Kun githubiin oli luonut uuden repon ja valinnut täpän lisenssin ja README kohdalle, oli aika kloonata se srv/hakemistoon, jolloin se loi _salt -kansion_ komennolla: 
 - sudo git clone http://github.com/OtsoR/salt.git

> xubuntu@xubuntu:/srv$ sudo git clone https://github.com/OtsoR/salt.git
Cloning into 'salt'...
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (7/7), done.
remote: Total 9 (delta 1), reused 5 (delta 0), pack-reused 0
Unpacking objects: 100% (9/9), done.
xubuntu@xubuntu:/srv$ ls
salt

Ilman sudoa srv:hen ei voinut kloonata gittiä. 

Sitten loin ssh moduulin asentamalla openssh-serverin ensin ja kopioimalla /etc/ssh/sshd_config salt/ssh knasioon, jonka olin luonut moduulia varten. Muutin konfigia ottamalla # pois portin kohdalta ja loin vielä init.sls tiedoston. johon muutin oikean polun sshd_config tiedostolle salt moduulissa. Tero Karvisen ohjeet: http://terokarvinen.com/2018/pkg-file-service-control-daemons-with-salt-change-ssh-server-port
Testasin, että moduuli toimii komennolla: 
 - sudo salt '*' state.apply ssh

Summary for otso
>  ------------
>  Succeeded: 3 (changed=2)
>  Failed:    0
>  ------------
>  Total states run:     3
>  Total run time:   1.425 s

Toimii!

Päivitys Github salt-repoon komennolla:
 - sudo git pull && sudo git push
 
>xubuntu@xubuntu:/srv/salt/ssh$ sudo git pull && sudo git push
Already up to date.
Username for 'https://github.com': OtsoR
Password for 'https://OtsoR@github.com': 
Counting objects: 9, done.
Delta compression using up to 4 threads.
Compressing objects: 100% (9/9), done.
Writing objects: 100% (9/9), 2.21 KiB | 2.21 MiB/s, done.
Total 9 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 1 local object.
To https://github.com/OtsoR/salt.git
   4c809b9..425665f  master -> master

### d) Näytä omalla salt-varastollasi esimerkit komennoista ‘git log’, ‘git diff’ ja ‘git blame’. Selitä tulokset

Tulokset git logista:
>xubuntu@xubuntu:/srv/salt/ssh$ git log
commit 425665f389d6aa0cb2454bac39f90c969e17305c (HEAD -> master, origin/master, origin/HEAD)
Author: Otso Rauta <otsorauta@hotmail.com>
Date:   Sun Nov 11 21:35:28 2018 +0000

 >   Salt ssh init.sls

>commit b697f3ea3b00f4b3cf37c4e09e8c0baffe035fbd
Author: Otso Rauta <otsorauta@hotmail.com>
Date:   Sun Nov 11 21:22:53 2018 +0000

  >  Sshd_config file in salt module

>commit 4c809b9952b3f766fbe9086550f514489a4c497e
Author: Otso Rauta <otsorauta@hotmail.com>
Date:   Tue Nov 6 15:15:23 2018 +0000

  >  Hellotso.txt sudo git testi

>commit 3facd523ef489453f9f575fbcee0bfaa06370919
Author: OtsoR <35492738+OtsoR@users.noreply.github.com>
Date:   Tue Nov 6 15:03:16 2018 +0000

  >  Initial commit
  
  Logista näkyy mitä ja kuka on tehnyt muutoksia tiedostoihin, kunhan on muistanut lisätä commit merkinnän. 
  
  Tulos git status:
 > xubuntu@xubuntu:/srv/salt/ssh$ git status
>On branch master
>Your branch is up to date with 'origin/master'.
>
>nothing to commit, working tree clean



##### Testasin git diff:iä,etsin siihen ohjeita, kun en heti tajunnut toimintoa. Käytin ohjeita sivulta: https://www.linuxnix.com/6-git-diff-command-examples/

Muutin hellotso.txt filua ja ajoin seuraavat komennot:

>xubuntu@xubuntu:/srv/salt/hello$ sudoedit hellotso.txt 
xubuntu@xubuntu:/srv/salt/hello$ cat hellotso.txt 
Tämä on hellotso txt testi 
>
>lisäsin uuden rivin git diff toivossa
xubuntu@xubuntu:/srv/salt/hello$ git status
On branch master
Your branch is up to date with 'origin/master'.

>Changes not staged for commit:
>  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

>	modified:   hellotso.txt

>no changes added to commit (use "git add" and/or "git commit -a")
**xubuntu@xubuntu:/srv/salt/hello$ git diff**
diff --git a/hello/hellotso.txt b/hello/hellotso.txt
index ddf7853..f4015bb 100644
--- a/hello/hellotso.txt
+++ b/hello/hellotso.txt
@@ -1 +1,3 @@
-Tämä on hellotso txt testi Helloworld muodossa
+Tämä on hellotso txt testi 
> +(tyhjä rivi) 
> +lisäsin uuden rivin git diff toivossa
xubuntu@xubuntu:/srv/salt/hello$ 

Eli git diffillä näkyi mitä oli muutettu. 

##### Git blamelläkin näkee milloin tiedostoa on muutettu ja onko sitä commitettu.

>xubuntu@xubuntu:/srv/salt/hello$ git blame hellotso.txt 
00000000 (Not Committed Yet 2018-11-11 22:26:28 +0000 1) Tämä on hellotso txt testi 
00000000 (Not Committed Yet 2018-11-11 22:26:28 +0000 2) 
00000000 (Not Committed Yet 2018-11-11 22:26:28 +0000 3) lisäsin uuden rivin git diff toivossa
xubuntu@xubuntu:/srv/salt/hello$ git blame hellotso.txt -L 3
00000000 (Not Committed Yet 2018-11-11 22:26:34 +0000 3) lisäsin uuden rivin git diff toivossa

git add . && git commit in jälkeen: 

>xubuntu@xubuntu:/srv/salt/hello$ git blame hellotso.txt 
624cf852 (Otso Rauta 2018-11-11 22:30:06 +0000 1) Tämä on hellotso txt testi 
624cf852 (Otso Rauta 2018-11-11 22:30:06 +0000 2) 
624cf852 (Otso Rauta 2018-11-11 22:30:06 +0000 3) lisäsin uuden rivin git diff toivossa


### e) Tee tyhmä muutos gittiin, älä tee commit:tia. Tuhoa huonot muutokset ‘git reset –hard’. Huomaa, että tässä toiminnossa ei ole peruutusnappia.

Muutin uudestaan hellotso.txt tiedostoa, 

>xubuntu@xubuntu:/srv/salt/hello$ sudoedit hellotso.txt 
xubuntu@xubuntu:/srv/salt/hello$ git diff
diff --git a/hello/hellotso.txt b/hello/hellotso.txt
index f4015bb..1325228 100644
--- a/hello/hellotso.txt
+++ b/hello/hellotso.txt
@@ -1,3 +1,10 @@
 Tämä on hellotso txt testi 
 
>-lisäsin uuden rivin git diff toivossa
+lisäsin uuden rivin git diff toivossa 
>
>+efsmsk  k sgkn lb  k öjb 
+rekn pkrn 
>
>+erknhk  pneh 
+päj psdhn 
>
>xubuntu@xubuntu:/srv/salt/hello$ 

##### ajoin git reset --hard -komennon, jonka jälkeen hellotso.txt oli palautunut:  
  
>xubuntu@xubuntu:/srv/salt/hello$ sudo  git reset --hard
HEAD is now at 624cf85 Hellotso git blame testi
xubuntu@xubuntu:/srv/salt/hello$ cat hellotso.txt 
Tämä on hellotso txt testi 

>lisäsin uuden rivin git diff toivossa

### f) Tee uusi Salt-moduuli

Tein sysstat- moduulin. Aloitin asentamalla sen ensiksi manuaalisesti koneelle. Etsin esimerkkejä tähän netistä ja käytin ohjeetksi esimerkkiä sivulta: https://tuomasolkinuora.wordpress.com/2018/10/09/configuration-management-systems-h1-and-h2/

- sudo apt install sysstat
 
Jonka jälkeen piti hakea hakemistosta **/etc/default/sysstat** asetustiedot. NIistä pitää enabloida 'false' true-arvoksi, jotta sysstat aktivoituisi. 

Tein sitten sysstat:ille uuden salt hakemiston
- sudo mkdir /srv/salt/sysstat  

Jonne loin sysstat_conf tiedoston, mihin kopioin **/etc/default/sysstat** sisällön ja muutin 'false' muuttujan 'true' -arvoksi- . Sitten loin init.sls tiedoston:

    sysstat:
      pkg.installed

    /etc/default/sysstat:
      file.managed:
        - source: salt://sysstat/sysstat_conf

    restart.sysstat:
      service.running:
        - name: sysstat
        - watch:
          - file: /etc/default/sysstat
          
Testasin että toimiiko:
- **sudo salt '*' state.apply sysstat**

Summary for otso
    ------------
    Succeeded: 3 (changed=2)
    Failed:    0
    ------------
    Total states run:     3
    Total run time: 586.369 ms

 eli toimi. 
 
 Testasin vielä parilla sysstat komennolla **mpstat, pidstat, iostat**, joilla tuli vastauksia. 
 
 Esimerkki iostat-komennosta:

![Tässä on kuva iostat komennosta, josta näkyy laitteiden nopeudet](https://github.com/OtsoR/salt/blob/master/Screenshot_2018-11-11_23-26-01.png)
 


  
  Lähteet:
   - https://www.linuxnix.com/6-git-diff-command-examples/
   - http://terokarvinen.com/2018/pkg-file-service-control-daemons-with-salt-change-ssh-server-port
   - http://terokarvinen.com/2018/aikataulu-%e2%80%93-palvelinten-hallinta-ict4tn022-3004-ti-ja-3002-to-%e2%80%93-loppukevat-2018-5p
   - http://terokarvinen.com/2016/publish-your-project-with-github
   - https://tuomasolkinuora.wordpress.com/2018/10/09/configuration-management-systems-h1-and-h2/
  



