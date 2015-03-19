************************************************************************
*
*     ListFunctions.f:
*
*     This subroutine lists all the functions available in APFEL.
*     It needs to be update constantly!
*
************************************************************************
      subroutine ListFunctions
*
      implicit none
*
      call WelcomeMessage
*
      write(6,*) "List of the functions available in APFEL:"
      write(6,*) "  "
*
      write(6,*) "---- Functions evolution module ----"
      write(6,*) "  "
*
      write(6,*) "Initialization functions:"
      write(6,*) "  "
      write(6,*) "- InitializeAPFEL():"
      write(6,*) "    initializes the APFEL library. If no settings has"
      write(6,*) "    been specified, it uses the default ones."
      write(6,*) "- EvolveAPFEL(double Q0, double Q):"
      write(6,*) "    evolves PDFs on the grid to the scale 'Q' [GeV]"
      write(6,*) "    starting from the scale 'Q0' [GeV]."
      write(6,*) "- DeriveAPFEL(double Q):"
      write(6,*) "    computes the logarithmic derivative with respect"
      write(6,*) "    of 'Q' of PDFs at the scale 'Q' [GeV]."
      write(6,*) "  "
*
      write(6,*) "Setting functions:"
      write(6,*) "  "
      write(6,*) "- SetPerturbativeOrder(int pto):"
      write(6,*) "    sets the perturbative order of the evolution"
      write(6,*) "    (pto = 0,1,2, default 2)."
      write(6,*) "- SetTheory(string theory):"
      write(6,*) "    sets the theory to be used in the evolution"
      write(6,*) "    (theory = 'QCD','QED','QUniD', default 'QCD')"
      write(6,*) "- SetVFNS():"
      write(6,*) "    sets the Variable-Flavour Number Scheme."
      write(6,*) "- SetFFNS(int nfl):"
      write(6,*) "    sets the Fixed-Flavour Number Scheme with 'nfl'"
      write(6,*) "    active flavours."
      write(6,*) "- SetAlphaQCDRef(double alpharef, double Qref):"
      write(6,*) "    sets the reference values of alphas at the scale"
      write(6,*) "    'Qref' [GeV] to 'alpharef' (default 'alpharef' ="
      write(6,*) "    0.35, 'Qref' = sqrt(2) GeV)."
      write(6,*) "- SetAlphaQEDRef(double alpharef, double Qref):"
      write(6,*) "    sets the reference values of alpha at the scale"
      write(6,*) "    'Qref' [GeV] to 'alpharef' (default 'alpharef' ="
      write(6,*) "    7.496252d-3, 'Qref' = 1.777 GeV)."
      write(6,*) "- SetLambdaQCDRef(double lambdaref, int nref):"
      write(6,*) "    sets the value of LambdaQCD [GeV] with 'nref'"
      write(6,*) "    flavours to 'lambdaref' (default 'lambdaref'"
      write(6,*) "    = 0.220, 'nref' = 5)"
      write(6,*) "- SetPoleMasses(double mc, double mb, double mt):"
      write(6,*) "    sets the values of the heavy quark thresholds"
      write(6,*) "    in GeV in the Pole-mass scheme (default 'mc' "
      write(6,*) "    = sqrt(2) GeV, 'mb' = 4.5 GeV, 'mt' = 175 GeV)."
      write(6,*) "- SetMSbarMasses(double mc, double mb, double mt):"
      write(6,*) "    sets the values of the heavy quark thresholds"
      write(6,*) "    in GeV in the MSbar scheme."
      write(6,*) "- SetTauMass(double mtau):"
      write(6,*) "    sets the values of the tau lepton in GeV"
      write(6,*) "    (default 'mtau' = 1.777 GeV)"
      write(6,*) "- EnableMassRunning(bool):"
      write(6,*) "    enables/disables the running of the MSbar masses"
      write(6,*) "    (default true)."
      write(6,*) "- SetMaxFlavourAlpha(int nf):"
      write(6,*) "    sets the maximum number of active flavours in the"
      write(6,*) "    couplings evolution (including the masses)"
      write(6,*) "    (default 'nf' = 6)."
      write(6,*) "- SetMaxFlavourPDFs(int nf):"
      write(6,*) "    sets the maximum number of active flavours in the"
      write(6,*) "    PDF evolution (default 'nf' = 6)."
      write(6,*) "- SetRenFacRatio(double ratio):"
      write(6,*) "    sets the ratio between factorization and"
      write(6,*) "    renormalization scales both in GeV (default"
      write(6,*) "    'ratio' = 1)."
      write(6,*) "- SetTimeLikeEvolution(bool):"
      write(6,*) "    sets the time-like evolution (frag. functions)"
      write(6,*) "    (default false)."
      write(6,*) "- SetSmallxResummation(bool, string la):"
      write(6,*) "    sets the the small-x resummation at 'la' log"
      write(6,*) "    accuracy ('la' = 'LL', 'NLL') (default false)."
      write(6,*) "- SetAlphaEvolution(string evol):"
      write(6,*) "    sets the solution of the beta function equations"
      write(6,*) "    for the running couplings ('evol' = 'exact',"
      write(6,*) "    'expanded', 'lambda') (default 'evol' = 'exact')"
      write(6,*) "- SetPDFEvolution(string evolp):"
      write(6,*) "    sets the solution of the DGLAP equations for PDFs"
      write(6,*) "    ('evolp' = 'exactmu', 'expandalpha',"
      write(6,*) "    'expandalpha') (default 'evolp' = 'exactmu')"
      write(6,*) "- SetPDFSet(string name):"
      write(6,*) "    sets the PDF set to be evolved. 'name' can be an"
      write(6,*) "    LHAPDF set (must finish with '.LHgrid'), some of"
      write(6,*) "    the internal set or an external set (default"
      write(6,*) "    'name' = 'ToyLH')."
      write(6,*) "- SetReplica(int nr):"
      write(6,*) "    sets the replica/member of the LHAPDF set to be"
      write(6,*) "    evolved (default 'nr' = 0)."
      write(6,*) "- SetQLimits(double Qmin, double Qmax):"
      write(6,*) "    sets the range where it is possible to perform"
      write(6,*) "    the evolution (default 'Qmin' = 0.5 GeV, 'Qmax'"
      write(6,*) "    = 1000 GeV)."
      write(6,*) "- SetNumberOfGrids(int n):"
      write(6,*) "    sets the number of subgrids 'n' (default 3)"
      write(6,*) "- SetGridParameters(int i, int n, int deg, double x):"
      write(6,*) "    sets the parameter of the i-th subgrid. 'n' ="
      write(6,*) "    number intevals, 'deg' = interpolation order,"
      write(6,*) "    'x' lower bound of the grid (the upper bound is"
      write(6,*) "    always 1)."
      write(6,*) "- SetExternalGrid(int i, int np, int deg, double *x):"
      write(6,*) "    sets the external grid in the position 'i' with"
      write(6,*) "    'np' intervals, interpolation degree 'deg'. 'x'"
      write(6,*) "    must be a one-dimentional array with upper bound"
      write(6,*) "    in 1 (there cannot be more than 1 external grid)."
      write(6,*) "- SetFastEvolution(bool):"
      write(6,*) "    sets the fast PDF evolution (default true)."
      write(6,*) "- GetVersion():"
      write(6,*) "    returns the APFEL version in use."
      write(6,*) "- EnableWelcomeMessage(bool):"
      write(6,*) "    enables the printing of the welcome message with"
      write(6,*) "    the APFEL banner and the report of the evolution"
      write(6,*) "    parameters (default true)."
      write(6,*) "- EnableEvolutionOperator(bool):"
      write(6,*) "    enables the computation of the external evolution"
      write(6,*) "    parameters (default false)."
      write(6,*) "- EnableLeptonEvolution(bool):"
      write(6,*) "    enables the evolution of the lepton PDFs when the"
      write(6,*) "    QED corrections are also enabled (default false)."
      write(6,*) "- LockGrids(bool):"
      write(6,*) "    locks the subgrids (default false)."
      write(6,*) "- CleanUp():"
      write(6,*) "    resets all the evolution parameters to the"
      write(6,*) "    default settings."
      write(6,*) "- ListFunctions():"
      write(6,*) "    lists all the functions available in APFEL."
      write(6,*) "   "
*
      write(6,*) "Output functions:"
      write(6,*) "  "
      write(6,*) "- xPDF(int i, double x) and xgamma(double x):"
      write(6,*) "    return 'x' times the i-th and the photon PDF"
      write(6,*) "    in 'x' at the final scale 'Q' [GeV] defined in"
      write(6,*) "    'EvolveAPFEL'."
      write(6,*) "- xPDFall(double x, double *xf):"
      write(6,*) "    returns at once 'x' times all the PDF in the"
      write(6,*) "    array xf[-6:6] computed in 'x' at the final scale"
      write(6,*) "    'Q' [GeV] defined in 'EvolveAPFEL'."
      write(6,*) "- xPDFj(int i, double x) and xgammaj(double x):"
      write(6,*) "    return 'x' times the i-th and the photon PDF"
      write(6,*) "    in 'x' at the final scale 'Q' [GeV] defined in"
      write(6,*) "    'EvolveAPFEL' interpolated on the joint grid."
      write(6,*) "- dxPDF(int i, double x) and dxgamma(double x):"
      write(6,*) "    return 'x' times the derivative in ln(Q^2) of"
      write(6,*) "    the i-th and the photon PDF in 'x' at the scale"
      write(6,*) "    'Q' [GeV] defined in 'DeriveAPFEL'."
      write(6,*) "- NPDF(int i, int N) and Ngamma(int N):"
      write(6,*) "    return the N-th moment of the i-th and the"
      write(6,*) "    photon PDF the final scale 'Q' [GeV] defined in"
      write(6,*) "    'EvolveAPFEL'."
      write(6,*) "- LUMI(int i, int j, double S):"
      write(6,*) "    returns the partonic luminosity of the i-th and"
      write(6,*) "    j-th partons for the CoM energy S [GeV^2] for the"
      write(6,*) "    final invariant mass Mx = Q [GeV] defined in "
      write(6,*) "    'EvolveAPFEL'."
      write(6,*) "- AlphaQCD(double Q):"
      write(6,*) "    returns the QCD strong coupling alpha_s at the"
      write(6,*) "    scale 'Q' [GeV]."
      write(6,*) "- AlphaQED(double Q):"
      write(6,*) "    returns the QED coupling alpha at the scale"
      write(6,*) "    'Q' [GeV]."
      write(6,*) "- HeavyQuarkMass(int i,double Q):"
      write(6,*) "    returns the mass of the i-th heavy quark"
      write(6,*) "    (i = 4,5,6) scale 'Q' [GeV] (the masses run only"
      write(6,*) "    when using the MSbar scheme)."
      write(6,*) "- nIntervals():"
      write(6,*) "    returns the number of intervals of the joint"
      write(6,*) "    grid."
      write(6,*) "- xGrid(int alpha):"
      write(6,*) "    returns the value of 'x' on the alpha-th node of"
      write(6,*) "    the joint grid."
      write(6,*) "- GetPerturbativeOrder():"
      write(6,*) "    returns the perturbative order set for the"
      write(6,*) "    evolution"
      write(6,*) "- ExternalEvolutionOperator(string fname,",
     1           " int i, int j, double x, int beta):"
      write(6,*) "    returns the PDF evolution operator."
      write(6,*) "- LHAPDFgrid(int Nrep, double Qin, string",
     1           " fname):"
      write(6,*) "    produces a PDF interpolation grid in the LHAPDF"
      write(6,*) "    format."
      write(6,*) "- LHAPDFgridDerivative(int Nrep, string",
     1           " fname):"
      write(6,*) "    produces an interpolation grid in the LHAPDF"
      write(6,*) "    format for the derived PDFs."
      write(6,*) "  "
*
      write(6,*) "---- Functions of the DIS module ----"
      write(6,*) "  "
      write(6,*) "- DIS_xsec(double x, double qi, double qf, double y,",
     1           " double pol,"
      write(6,*) "           string proc, string scheme,"
      write(6,*) "           int pto, string pdfset, int irep,"
      write(6,*) "           string target, string proj,"
      write(6,*) "           double *F2, double *F3, double *FL,",
     1           " double *sigma):"
      write(6,*) "    old DIS module (deprecated)."
      write(6,*) "  "
      write(6,*) "Initialization functions:"
      write(6,*) "  "
      write(6,*) "- InitializeAPFEL_DIS():"
      write(6,*) "    initializes the DIS module. If no settings has"
      write(6,*) "    been specified, it uses the default ones."
      write(6,*) "- ComputeStructureFunctionsAPFEL(double Q0,double Q):"
      write(6,*) "    computes the DIS structure functions on the grid"
      write(6,*) "    at the scale 'Q' [GeV] applying also the PDF"
      write(6,*) "    evolution from the initial scale 'Q0' [GeV]."
      write(6,*) "  "
      write(6,*) "Setting functions:"
      write(6,*) "  "
      write(6,*) "- SetMassScheme(string ms):"
      write(6,*) "    sets the mass scheme to be used to compute the"
      write(6,*) "    structure functions ('ms' = 'ZM-VFNS', 'FFNS',"
      write(6,*) "    'FONLL-A', 'FONLL-B', 'FONLL-C', default 'ms' ="
      write(6,*) "    'ZM-VFNS')."
      write(6,*) "- SetPolarizationDIS(double pol):"
      write(6,*) "    sets the beam polarization (defaul 'pol' = 0)."
      write(6,*) "- SetProcessDIS(string pr):"
      write(6,*) "    sets process ('pr' = 'EM', 'NC', 'CC', default"
      write(6,*) "    'pr' = 'EM')."
      write(6,*) "- SetProjectileDIS(string lept):"
      write(6,*) "    sets the projectile ('lept' = 'electron',"
      write(6,*) "    'positron', 'neutrino', 'antineutrino', default"
      write(6,*) "    'lept' = 'electron')."
      write(6,*) "- SetTargetDIS(string tar):"
      write(6,*) "    sets the target ('tar' = 'proton', 'neutron',"
      write(6,*) "    'isoscalar', 'iron', default 'tar' = 'proton')"
      write(6,*) "- SetZMass(double massz):"
      write(6,*) "    sets the value of the mass of the Z boson"
      write(6,*) "    (default 'massz' = 91.1876 GeV)."
      write(6,*) "- SetWMass(double massw):"
      write(6,*) "    sets the value of the mass of the W boson"
      write(6,*) "    (default 'massw' = 80.385 GeV)."
      write(6,*) "- SetProtonMass(double massp):"
      write(6,*) "    sets the value of the mass of the proton"
      write(6,*) "    (default 'massp' = 0.938272046 GeV)."
      write(6,*) "- SetSinThetaW(double sw):"
      write(6,*) "    sets the value of sin(theta_W)"
      write(6,*) "    (default 'sw' = 0.23126)."
      write(6,*) "- SetGFermi(double gf):"
      write(6,*) "    sets the value of Fermi constant"
      write(6,*) "    (default 'gf' = 1.1663787e-5)."
      write(6,*) "- SetCKM(double vud, double vus, double vub,"
      write(6,*) "         double vcd, double vcs, double vcb,"
      write(6,*) "         double vtd, double vts, double vtb):"
      write(6,*) "    sets the absolute value of the entries of the"
      write(6,*) "    CKM matrix"
      write(6,*) "    (default: 0.97427d0, 0.22536d0, 0.00355d0,"
      write(6,*) "              0.22522d0, 0.97343d0, 0.04140d0,"
      write(6,*) "              0.00886d0, 0.04050d0, 0.99914d0)."
      write(6,*) "- EnableTargetMassCorrections(bool):"
      write(6,*) "    enables or disables the target mass corrections"
      write(6,*) "    to the DIS structure functions due to the finite"
      write(6,*) "    mass of the proton."
      write(6,*) "- SelectCharge(string selch):"
      write(6,*) "    selects one particular charge in the NC structure"
      write(6,*) "    functions ('selch' = 'down', 'up', 'strange',"
      write(6,*) "    'charm', 'bottom', 'top', 'all', default "
      write(6,*) "    'selch' = 'all')"
      write(6,*) "  "
*
      write(6,*) "Output functions:"
      write(6,*) "  "
      write(6,*) "- F2light(double x), F2charm(double x),",
     1            " F2bottom(double x),"
      write(6,*) "  F2top(double x), F2total(double x):"
      write(6,*) "- FLlight(double x), FLcharm(double x),",
     1            " FLbottom(double x),"
      write(6,*) "  FLtop(double x), FLtotal(double x):"
      write(6,*) "- F3light(double x), F3charm(double x),",
     1            " F3bottom(double x),"
      write(6,*) "  F3top(double x), F3total(double x):"
      write(6,*) "    return the F2, FL and xF3 struncture functions in"
      write(6,*) "    'x' at the final scale 'Q' [GeV] defined in"
      write(6,*) "    'ComputeStructureFunctionsAPFEL'."
      write(6,*) "- GetZMass():"
      write(6,*) "    returns the value of the mass of the Z boson"
      write(6,*) "- GetWMass():"
      write(6,*) "    returns the value of the mass of the W boson"
      write(6,*) "- GetProtonMass():"
      write(6,*) "    returns the value of the mass of the proton"
      write(6,*) "- GetSinThetaW():"
      write(6,*) "    returns the value of sin(theta_W)"
      write(6,*) "- GetGFermi():"
      write(6,*) "    returns the value of Fermi constant"
      write(6,*) "- GetCKM(int u, int d):"
      write(6,*) "    returns the absolute value of the (u,d) entry"
      write(6,*) "    of the CKM matrix"
      write(6,*) "- ExternalDISOperator(string SF, int ihq,",
     1           " int i, double x, int beta):"
      write(6,*) "    returns the DIS operators."
      write(6,*) "  "
*
      write(6,*) "Special functions for the production of FK tables"
      write(6,*) "used in the NNPDF fits:"
      write(6,*) "  "
      write(6,*) "- SetFKObservable(string obs)"
      write(6,*) "- GetFKObservable()"
      write(6,*) "- FKSimulator(string obs, double x,",
     1           " double q, double y, int i, int beta)"
      write(6,*) "- FKObservables(string obs, double x,",
     1           " double q, double y)"
      write(6,*) "   "
*
      return
      end
