CREATE DATABASE despensa;
USE despensa;

CREATE TABLE Users
(
    id_user INT NOT NULL,
    email VARCHAR(50) NOT NULL,
    psswd VARCHAR(100) NOT NULL,
    hash_psswd VARCHAR(100) NOT NULL,
    name_user VARCHAR(50) NOT NULL,
    date_registered DATETIME NOT NULL,
    PRIMARY KEY (id_user)
);

CREATE TABLE Recipes
(
    id_recipe INT NOT NULL,
    id_user INT NOT NULL,
    name_recipe VARCHAR(50) NOT NULL,
    img_addr VARCHAR(50),
    prep_time TIME NOT NULL,
    prep_method TEXT,
    rating FLOAT,
    observation TEXT,
    last_made DATETIME,
    date_registered DATETIME NOT NULL,
    PRIMARY KEY (id_recipe),
    FOREIGN KEY (id_user) REFERENCES Users(id_user)
);

CREATE TABLE Ingredients
(
	id_ingredient INT NOT NULL,
    name_ingredient VARCHAR(20) NOT NULL,
    PRIMARY KEY(id_ingredient)
);

CREATE TABLE Tags
(
	id_tag INT NOT NULL,
    description_tag VARCHAR(20) NOT NULL,
    PRIMARY KEY(id_tag)
);

CREATE TABLE Recipe_Ingredients
(
	id_recipe INT NOT NULL,
    id_ingredient INT NOT NULL,
    PRIMARY KEY(id_recipe, id_ingredient),
    FOREIGN KEY (id_recipe) REFERENCES Recipes(id_recipe),
    FOREIGN KEY (id_ingredient) REFERENCES Ingredients(id_ingredient)
);

CREATE TABLE Recipe_Tags
(
	id_recipe INT NOT NULL,
    id_tag INT NOT NULL,
    PRIMARY KEY(id_recipe,id_tag),
    FOREIGN KEY (id_recipe) REFERENCES Recipes(id_recipe),
    FOREIGN KEY (id_tag) REFERENCES Tags(id_tag)
);