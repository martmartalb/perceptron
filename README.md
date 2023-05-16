# 3DRISES AI development

In order to start working in this project, please follow the step 1 described below.

## 1. Configure the environment

In order to configure the python environment, _pipenv_ is neede to be installed in your python base. This package is a tool that automatically creates and manages virtualenv.

```
# Windows
python -m pip install pipenv
# Linux
python3 -m pip install pipenv
```

This will install _pipenv_ for the first Python in your path, so if you have more than one version installed, be aware of that. One additional configuration that is **strongly recommended to be done** is to specify that we want to create the virtualenv in the same project folder, so in order to do that we need to create an environment variable specifiying this.

```
# Windows
setx PIPENV_VENV_IN_PROJECT 1
# Linux (open .bashrc and copy the next line at the bottom of the file)
export PIPENV_VENV_IN_PROJECT=1
```

Once this is done, go to the root of the project, **open a new terminal, so the previous changes take effect**, and run the next command.

```
# Windows
python -m pipenv install
# Linux
python3 -m pipenv install
```

This will create the python environment and will install all the necessary packages. After that, you will see a _.venv_ in the root of the project. If you cannot see that, probably the environment have been created in another location (the default location in which pipenv creates the virtualenvs is **C:\\Users\\your_user_name\\.virtualenvs** in Windows or **/home/your_user_name/.virtualenvs** in Linux). Be sure that the above environment variable have been create properly, close the terminal, open a new one, and try again.

## 2. Project structure

The project structure is summarized below. Please, clone the repository in the folder where database is located

```
├── docs                                # Project documentation
├── src                                 # Project files
    ├── vhdl                            # All relate to vhdl code
    ├── python                          # All relate to python code
        ├── models                      # Python package with proposed models
            ├── BaseModel.py            # Parent class of all the models
        ├── notebooks                   # Jupyter notebooks, playgrounds.
├── Pipfile                             # Pipenv file with python dependencies
└── README.md
```

### Who do I talk to?

- Ruben Padial (<rubenpadial@ugr.es>)
- Alberto Martin (<martmartalb@correo.ugr.es>)
