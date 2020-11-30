# Nomad consul

The aim of this project is to provide a development environment based on consul and nomad to manage container based microservices.

The following steps should make that clear;

bring up the environment by using vagrant which will create centos 7 virtualbox machine or lxc container.

The proved working vagrant providers used on an ArchLinux system are

vagrant-lxc
vagrant-libvirt
virtualbox
    $ vagrant up --provider lxc
    OR
    $ vagrant up --provider libvirt
    OR
    $ vagrant up --provider virtualbox
Once it is finished, you should be able to connect to the vagrant environment through SSH and interact with Nomad:

    $ vagrant ssh
    [vagrant@nomad ~]$
    
# Opdracht 2 Documentatie ---> Team 16 
## Opgave:

Per 2 (overzicht), met behulp van vagrant de nomad cluster uit de eerste opdracht nu niet met bash maar met ansible of puppet op brengen. Maak hiervoor gebruik van de puppet of ansible provisioner.

Er dienen voor deze opdracht verschillende modules geschreven te worden als ook roles (en profiles) samen met een node manifest of play. Het gebruik van parameters en templates voor de configuraties waar nodig wordt ten zeerste aangeraden!

Verdeel het werk onderling, zodanig ieder zelf code schrijft en dit ook duidelijk wordt uit de git history.

Nomad en consul te werken zoals beoogd in de eerste opdracht! Er zal ook deze keer gekeken worden met behulp van een nomad job file of de cluster werkt zoals vooropgesteld.

## Plan van aanpak: 

Bij de start van deze opdracht hebben we de hele mappenstructuur overgenomen van ansible. 
Voor te beginnen hebben we een aantal service roles aangemaakt voor nomad, consul en docker. Deze service roles hebben we dezelfde structuur gegeven op basis van de service crond. Wanneer dit allemaal was uitgevoerd hadden we de default set-up voor ons en konden we beginnen met aanpassingen te doen aan alle bestanden. Hieronder ziet u een foto van onze mappenstructuur:

![Image of Files](https://github.com/roelpxl/PXL_nomad/blob/team16/GitFilesTree.png)

Opdracht 2 zit volledig in de map ansible.
Binnen de map ansible hebben we onze Vagrantfile en een map genaam ansible.
Binnen deze map ansible hebben we 2 folders plays en roles.
We hebben besloten onze group_vars en host_vars folders onder de plays te zetten.
De rest van de structuur is overgenomen van de https://github.com/visibilityspots/PXL_nomad repo.
Wij hebben hier natuurlijk de crond folder verander door de consul, docker en nomad folder.

Wij hebben het werk wat verdeeld onderling: Roel heeft de service roles docker en consul voor zijn rekening gehouden en Kobe heeft de service role nomad opgemaakt. We hebben voor elke service role defaults, tasks, templates en handlers geschreven. Hierna hebben onze vagrantfile gemodificeerd, waar we 2 client nodes (+ server node deze staat ook als client) en 1 server node opzetten. Zo konden we service roles controleren en foutcontrole op doen: door vagrant up te doen en te kijken als er eventueel fouten optreden bij het doorlopen van de verschillende stappen. 

#Roel:
Ik ben begonnen met het werken aan de docker file. Ik wist dat we docker-ce moesten installeren en heb meteen gezocht naar een download link.
Deze was niet al te moeilijk te vinden. Vervolgens heb ik tutorials opgezocht om docker-ce te downloaden binnen ansible.
Hier zijn veel verschillende tutorials door gegaan tot ik uiteindelijk een werkend eind resultaat had.
Voor docker maak ik alleen gebruik van de tasks en handlers.
Binnen de tasks voorzie ik de juiste download link voor centos en vervolgens laat ik de handler starten.
De handler zet na de installatie de docker service aan.

Vervolgens ben ik begonnen aan de nomad installatie. Hier heb ik eerst hetzelfde gedaan als voor docker zodat de installatie van nomad inorde was.
Na de installatie ben ik begonnen met opzoek hoe je files kunt overschrijven. zie bijlage voor handler.
Deze heb ik volledig uigeschreven en uiteindelijk hebben we dit niet gebruikt.
We zijn moeten overschakelen naar het gebruiken van templates.
Voor we zijn overgeschakeled hebben we ook gezien welke variable we nodig hebben voor de nomad en consul configuratie in te stellen.
Zo hebben we voor beide het huidige ip addres en het server ip addres nodig.
Na verder na te denken moesten we weten of het de server configuratie is of een client configuratie.
Ik had ook het bootstrap aantal binnen meegenomen (dit is uiteindelijk niet meer nodig).
Dit staat allemaal in de group_vars.
Omdat de node_name uniek is per client/server hebben we deze binnen host_vars mee gegeven.


## Problemen: 
#Probleem 1:
We hebben eerst geprobeerd om dit allemaal te draaien in een ubuntu server.
Dit werkte niet omdat deze door virtualbox werd gehost en virtualbox nesting support.

#Oplossing:
Roel had al gehoord van zijn groepsgenoten van het project dat het niet zo moeilijk was om het op windows te draaien.
Er moet gewoon ansible_local gebruikt worden.

#Probleem 2:
We hebben veel problemen ondervonden bij het editeren van de config files van zowel consul als nomad.
We hadden allebij een andere oplossing zitten proberen maar we zijn bijde vastgelopen bij onze eigen oplossing.
Roel heeft eerst gebruik gemaakt van handlers die de file moesten editeren lijn per lijn.
Kobe heeft geporbeerd een template die de bestaande file moest vervangen.

#Probleem 3:
Bij zijn fout gelopen maar de handlers leken het meest belovend.
Bij het uitvoeren van de handlers lijkt het of de group_vars en hosts_vars niet gevonden worden.

#Oplossing 3:
Het verplaatsen van de group_vars en hosts_vars naar de roles map zorgde ervoor dat deze wel gevonden werden.
Dit leek een juiste oplossing door het slecht lezen van: https://stackoverflow.com/questions/43162620/host-vars-and-group-vars-are-not-getting-loaded

#Oplossing 2:
Na het grondig test van de handlers lijken hier af en toe problemen mee te zijn.
Het overstappen naar een template was de betere oplossing.


## Bijlagen:

Voor handler: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html

Voor template:
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html
