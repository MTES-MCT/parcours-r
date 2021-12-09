# Contributions

## Comment contribuer depuis le SSPCloud ?

### Explications

Passer par le SSPCloud permet d'avoir l'image avec l'ensemble des packages déjà installés.
L'image donne aussi accès à  :

  - terminal zsh et la configururation [oh my zh](https://ohmyz.sh/)
  - [gh cli](https://cli.github.com/) (github client)

En particulier, cela permet d'avoir accès à un certain nombre d'alias : https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

### Prérequis

#### Création des tokens sous github
https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token

#### Enregistrer les tokens sous le sspcloud

La documentation explique pas à pas comment créer des secrets sur le sspcloud :
https://docs.sspcloud.fr/onyxia-guide/gestion-des-secrets

1. Créer un dossier `parcours_r` dans les secrets

1. Créer un secret `tokens` et y entrer les variables suivantes

  | Nom de la variable | Valeur                                                                                 |
  |--------------------|----------------------------------------------------------------------------------------|
  | URL_GITHUB         | `https://<username>:<token_github>@github.com`                                      |
  | GH_TOKEN           | `<gh_token>`                                                                           |

Seule la variable GH_TOKEN est nécessaire puisque vous pouvez aussi utiliser l' identifiant git et le token github
si vous les avez configurés sur la page : https://datalab.sspcloud.fr/account/third-party-integration

### Se rendre sur la page d'accueil du projet et lancer un service par lien de contribution
