# Galaxy Tool wrapper for UNAFold #

This is the [Galaxy](http://usegalaxy.org) wrapper for the [UNAFold](http://mfold.rna.albany.edu/?q=DINAMelt/software). UNAFold software was developed for nucleic acid folding and hybridization prediction ([doi: 10.1007/978-1-60327-429-6_1](http://dx.doi.org/10.1007/978-1-60327-429-6_1), [doi: 10.1093/nar/gki591](http://dx.doi.org/10.1093/nar/gki591)). This wrapper is not yet deposited in the Tool-Shed repository, so this is the single place where it can downloaded.

## Installation ##

* Save [UNAFold.pl](http://mfold.rna.albany.edu/?q=DINAMelt/software) in your $PATH, that is accesable to the Galaxy.

* Create the directory `unafold` in `$GALAXY_DIR/tools/` and copy `unafold.xml` and `unafold.sh` files into it.
* Add the Galaxy tool definition to the `tools_conf.xml`:
```html
    <section id="unafold_tool" name="UNAFold">
        <tool file="unafold/unafold.xml" />
    </section>`
```

* Please, be sure that `zip` datatype is registered in your Galaxy instance. If not, add the following string to the `datatypes_conf.xml` file:
```html
    <datatype extension="zip" type="galaxy.datatypes.binary:Binary" mimetype="application/zip" subclass="True" />
```

* Reload the Galaxy instance.
