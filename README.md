# MonsterMeeter
_Random encounter generator for D&D (any edition) and any other RPG that uses the concept of Challenge Rating._

## Features

* Create custom terrains and only roll for monsters in those terrains
* Add your own monsters
* Automatic difficulty scaling
* Encounter rolls based on exponential difficulty curve (3d6 vs 1d20)
* Prepopulated with D&D 5th Ed Monsters and their default terrains
* Add a "Hostility" rating and a "Normality" rating to monsters (unused at the moment)

## Planned Features
* Generate encounters based on hostility and normality

## Installation

1. `$ git clone https://github.com/Pinwheeler/MonsterMeeter.git`
2. `$ cd MonsterMeeter/`
3. `$ bundle install`
5. `$ cd db/`
6. `$ rake db:drop`
7. `$ rake db:create`
8. `$ sqlite3 development.sqlite3 < development.back`
9. `$ rails s`
9. Navigate to [http://localhost:3000/](http://localhost:3000/)
