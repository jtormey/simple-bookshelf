# Bookshelf

## Google Cloud

Deploy: `gcloud app deploy --project solar-vertex-259118`

## Delivery

* Build a release: `mix edeliver build release`
* Deploy a release: `mix edeliver deploy release to production`
* Start a release: `mix edeliver start production`
* Restart a release: `mix edeliver start production`
* Migrate database: `mix edeliver migrate production`

Perform a cold release: `build`, `deploy`, (`migrate`?), `restart`
