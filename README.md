# ELL-Docker

Setting up your Raspberry Pi Zero for running [Microsoft ELL](https://github.com/Microsoft/ELL) is painfully long with many setup steps. Therefore I decided to create a docker image to ease the whole setup and we can focus on our application logic only for using ELL.

#### Run ELL with Docker

If you just want to run the [ELL tutorial](https://microsoft.github.io/ELL/tutorials/Getting-started-with-image-classification-on-the-Raspberry-Pi/) from the official ELL repository, follow the instruction there and get a copy of built model folder on your Raspberry Pi Zero. Then in your model folder, create a script called **run_tutorial.sh** which includes the commands to trigger the tutorial python script:

```shell
#!/bin/bash -e

python3 call_model.py
```

Then clone/copy this repository onto your Pi. Simply run the following command to trigger the tutorial script from ELL tutorial:

```shell
<ELL-Docker-root>/scripts/run-ell.sh -i <path-to-model-folder>
```

That's it.

#### Build your own docker image for running ELL

if your want to build your own docker image for running ELL, check the Dockerfile and scripts in the docker-build folder under this repository. You can build your own image by running the following on your Windows/Mac/Linux with the Docker installed:

```shell
cd <ELL-Docker-root>/docker-build
docker build <image-name>:<image-tag> .
```


