[![Circle CI](https://circleci.com/gh/scarrazza/apfel/tree/master.svg?style=svg)](https://circleci.com/gh/scarrazza/apfel/tree/master)

![alt text](https://github.com/scarrazza/apfel/raw/master/resources/logoapfel.png "Logo APFEL")

# APFEL: A PDF Evolution Library

Visit: http://apfel.hepforge.org and http://apfel.mi.infn.it/
 
APFEL is a library able to perform DGLAP evolution up to NNLO in QCD
and to NLO in QED, both with pole and MSbar masses. The coupled DGLAP
QCD+QED evolution equations are solved in x-space by means of higher
order interpolations and Runge-Kutta techniques.

The APFEL library is accessible also through the APFEL Web
interface. APFEL Web provides an online web-application which
integrates several HEP softwares providing a complete suite plotting
tools for PDFs and many related quantities (http://apfel.mi.infn.it/).

## Download

You can obtain APFEL directly from the GitHub repository:

https://github.com/scarrazza/apfel/releases

For the last development version you can clone the master code:

```Shell
git clone https://github.com/scarrazza/apfel.git
```

For the latest tag:

```Shell
git tag -l
git checkout tags/tag_name
```

## Installation

The code can be compiled using the following procedure:

```Shell
cd apfel
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=/your/installation/path/ ..
make && make install
```
By the default, if no prefix is given, the program will
be installed in the /usr/local folder. If you want (or need) to use a
different path, remember to export the APFEL `/lib` and `/bin` folders into the
`$LD_LIBRARY_PATH` and `$PATH`, respectively. More configuration
options can be accessed by typing:

```Shell
ccmake .
```

## Known issues

If you observe memory issues while running APFEL on specific machines you can move the memory allocation to heap by adding the `-fno-automatic` flag:
```bash
export FFLAGS=$(echo $FFLAGS | sed 's/-fopenmp/-fno-automatic/g')
./configure --prefix=$PREFIX 
```

## References

- V. Bertone, S. Carrazza, J. Rojo, *APFEL: A PDF Evolution Library with QED corrections*, [arXiv:1310.1394](http://arxiv.org/abs/arXiv:1310.1394).
- S. Carrazza, A. Ferrara, D. Palazzo, J. Rojo, *APFEL Web: a web-based application for the graphical visualization of parton distribution functions*, [arXiv:1410.5456](http://arxiv.org/abs/1410.5456).

## Contact Information

Maintainers: Valerio Bertone, Stefano Carrazza

Homepage: http://apfel.hepforge.org/
