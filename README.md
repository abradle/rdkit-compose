###Django rdkit server using compose

Assumes you have installed Docker...

First install docker-compose 

```pip install docker-compose```

Second build the images

```#bash
git clone git@github.com:abradle/rdkit-compose.git
cd rdkit-compose
mv secrets.env.sample secrets.env
docker-compose build
```


Third launch them

```docker-compose up```
