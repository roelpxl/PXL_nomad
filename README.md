# Opdracht 3 Documentatie ---> Team 16 
## Opgave:

Per 2 ( overzicht), met behulp van vagrant de nomad cluster uit de tweede opdracht monitoring opzetten op basis van metrics (prometheus, alertmanager, grafana)
Deze dienen allen als container te worden gestart op de nomad cluster. Ook de node-exporter dient als container te worden opgespint op ALLE nodes.

De setup dient te worden geconfigureerd zodanig je nomad/consul cluster gemonitord wordt alsook een extra zelf uit te kiezen applicatie (ook een nomad job waarvan je de metrics binnenhaalt)

De prometheus en alertmanager targets liefst dynamisch geconfigureerd zoals geillustreerd tijdens de les. Dashboards dienen te worden voorzien via grafana, de json export plaats je in je git repository zodanig ze kunnen worden geimporteerd tijdens de evaluatie.

Er dient van deze jobs niets automatisch te worden opgezet via vagrant up (mag wel) de nomad jobs dienen wel aanwezig te zijn in de git repository!

Tijdens het evaluatie moment dient er een vagrant destroy vagrant up te gebeuren waarna jullie stap voor de stap door de monitoring jobs lopen, manueel starten, eventuele grafana configuratie toepassen en de dashboards inladen.


## Plan van aanpak: 
Bij deze opdracht maken we gebruik van 3 vm's, namelijk:

* Server
* Client1
* Client2

```bash


```














## Bijlagen:

Voor handler: https://docs.ansible.com/ansible/latest/collections/ansible/builtin/lineinfile_module.html

Voor template:
https://docs.ansible.com/ansible/latest/collections/ansible/builtin/template_module.html
