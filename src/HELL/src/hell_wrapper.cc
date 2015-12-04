/**
 * Fortran WRAPPER FOR HELL
 * stefano.carrazza@mi.infn.it
 */

#include "HELL/include/hell.hh"
#include "HELL/include/hell_wrapper.hh"

#include <iostream>
#include <string>
using namespace std;

#define STR_EXPAND(top) #top
#define STR(tok) STR_EXPAND(tok)

// Global allocation
HELLx::LogOrder order;
HELLx::HELLx *sxD = NULL;
HELLx::Order fixed_order_to_be_matched_to;
HELLx::sqmatrix<double> xdPNLL;

string HELLdataPath()
{
  string dataDir(STR(DATA_PATH));
  stringstream s;
  s << dataDir << "/apfel";
  return s.str();
}

extern "C" {

  void helllogorder_(int *ord)
  {    
    if (*ord == 0)
      order = HELLx::LL;
    else 
      order = HELLx::NLL;
  }

  void hell_(double *asmc, double *asmb, double *asmt)
  {
    if (sxD) delete sxD;
    sxD = new HELLx::HELLx(order, HELLdataPath());
    sxD->init_as_thresholds(*asmc,*asmb,*asmt);
  }

  void hellorder_(int *ord)
  {
    if (*ord == -1)
      fixed_order_to_be_matched_to = HELLx::none;
    else if (*ord == 0)
      fixed_order_to_be_matched_to = HELLx::LO;
    else if (*ord == 1)
      fixed_order_to_be_matched_to = HELLx::NLO;
    else if (*ord == 2)
      fixed_order_to_be_matched_to = HELLx::NNLO;	
  }

  double xdeltap_(int *k, double *as, double *x)
  {
    xdPNLL = sxD->DeltaP(*as, *x, fixed_order_to_be_matched_to);
    double xdp = 0;
    if(*k == 4)      xdp = xdPNLL.qq();
    else if(*k == 5) xdp = xdPNLL.qg();
    else if(*k == 6) xdp = xdPNLL.gq();
    else if(*k == 7) xdp = xdPNLL.gg();
    return xdp;
    /*
    cout << endl << "Printing x*DeltaP_ij(x=" << *x << ", as=" << *as << ")"  << endl;
    cout << "gg: " << xdPNLL.gg() << endl
	 << "gq: " << xdPNLL.gq() << endl
	 << "qg: " << xdPNLL.qg() << endl
	 << "qq: " << xdPNLL.qq() << endl;
    */
  }
}
