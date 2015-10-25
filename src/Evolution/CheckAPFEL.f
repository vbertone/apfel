************************************************************************
*
*     CheckAPFEL.f:
*
*     Code that tests APFEL against a pretabulated set of results for:
*     - alpha_s,
*     - evolution,
*     - structure functions.
*
************************************************************************
      function CheckAPFEL()
*
      implicit none
**
*     Internal Variables
*
      integer ilha,iQ,iref
      double precision Q20,Q2(4),Q0,Q
      double precision xlha(9)
      double precision eps
      double precision toll
      double precision AlphaQCD,AlphaQED
      double precision xPDFj
      double precision F2light,F2charm,F2bottom,F2total
      double precision FLlight,FLcharm,FLbottom,FLtotal
      double precision F3light,F3charm,F3bottom,F3total
      double precision Ref(616)
      character*6 apfelversion
      logical succ
      parameter(eps=1d-10)
      parameter(toll=1d-6)
**
*     Output Variables
*
      logical CheckAPFEL
*
      data Q20  / 2d0 /
      data Q2   / 10d0, 100d0, 1000d0, 10000d0 /
      data xlha / 1d-5, 1d-4, 1d-3, 1d-2, 1d-1, 3d-1, 5d-1, 7d-1, 9d-1 /
      data Ref /
     1     2.442349E-01,
     1     1.193939E-03,  7.485935E-04,  6.869041E+00,  1.829460E+00,
     1     2.656613E+01,
     1     2.059303E+00,  6.988237E-01,  2.094048E-02,  2.779067E+00,
     1     3.876623E-01,  1.006200E-01,  6.704611E-04,  4.889528E-01,
     1     1.256974E-06,  3.480657E-08,  0.000000E+00,  1.291781E-06,
     1     6.082459E-03,  3.673987E-03,  4.311435E+00,  9.812364E-01,
     1     1.709241E+01,
     1     1.261344E+00,  3.491198E-01,  8.854254E-03,  1.619318E+00,
     1     2.664884E-01,  5.549607E-02,  3.046585E-04,  3.222891E-01,
     1     5.598434E-06,  6.595670E-08,  0.000000E+00,  5.664390E-06,
     1     3.154258E-02,  1.862850E-02,  2.635698E+00,  4.833360E-01,
     1     9.872000E+00,
     1     7.694275E-01,  1.511541E-01,  2.724934E-03,  9.233065E-01,
     1     1.678034E-01,  2.699601E-02,  1.043872E-04,  1.949038E-01,
     1     2.491742E-05,  5.059209E-08,  0.000000E+00,  2.496801E-05,
     1     1.600658E-01,  9.286229E-02,  1.506557E+00,  2.029548E-01,
     1     4.752753E+00,
     1     5.042107E-01,  5.021664E-02,  3.238022E-04,  5.547512E-01,
     1     9.453622E-02,  1.008401E-02,  1.414089E-05,  1.046344E-01,
     1     1.074162E-04, -8.526276E-08,  0.000000E+00,  1.073309E-04,
     1     5.924226E-01,  3.096037E-01,  4.697923E-01,  3.813648E-02,
     1     1.253566E+00,
     1     4.001067E-01,  4.740535E-03,  8.338509E-11,  4.048473E-01,
     1     3.948681E-02,  9.008050E-04,  8.354839E-13,  4.038762E-02,
     1     3.524933E-04, -8.802007E-08,  0.000000E+00,  3.524053E-04,
     1     5.532562E-01,  2.227810E-01,  6.641605E-02,  4.054517E-03,
     1     2.148372E-01,
     1     2.810472E-01,  3.778803E-04,  0.000000E+00,  2.814251E-01,
     1     1.391783E-02,  2.626936E-05,  0.000000E+00,  1.394410E-02,
     1     3.456557E-04, -1.528090E-08,  0.000000E+00,  3.456404E-04,
     1     2.609795E-01,  7.458363E-02,  6.246513E-03,  3.573108E-04,
     1     2.982527E-02,
     1     1.422937E-01,  5.533935E-05,  0.000000E+00,  1.423491E-01,
     1     3.877547E-03,  1.460818E-06,  0.000000E+00,  3.879008E-03,
     1     1.850429E-04, -2.078385E-09,  0.000000E+00,  1.850409E-04,
     1     6.207093E-02,  1.058890E-02,  2.033670E-04,  1.269359E-05,
     1     1.897703E-03,
     1     4.198172E-02,  3.461281E-06,  0.000000E+00,  4.198518E-02,
     1     5.306756E-04,  3.359298E-08,  0.000000E+00,  5.307092E-04,
     1     5.476675E-05, -1.416449E-10,  0.000000E+00,  5.476660E-05,
     1     2.065315E-03,  1.169151E-04,  1.785933E-07,  1.864313E-08,
     1     9.041930E-06,
     1     2.383137E-03,  1.092800E-08,  0.000000E+00,  2.383148E-03,
     1     6.605658E-06,  2.206940E-11,  0.000000E+00,  6.605680E-06,
     1     3.037889E-06, -6.765384E-13,  0.000000E+00,  3.037888E-06,
     1     1.762926E-01,
     1     1.954225E-03,  1.216954E-03,  1.480499E+01,  5.848240E+00,
     1     7.856866E+01,
     1     4.586623E+00,  2.392351E+00,  2.257678E-01,  7.204742E+00,
     1     8.645679E-01,  4.779515E-01,  3.459189E-02,  1.377111E+00,
     1     1.746129E-05,  8.735282E-07,  5.626028E-08,  1.839108E-05,
     1     9.179442E-03,  5.493776E-03,  7.969802E+00,  2.850759E+00,
     1     4.030636E+01,
     1     2.437475E+00,  1.143128E+00,  9.856550E-02,  3.679169E+00,
     1     4.565870E-01,  2.385162E-01,  1.594611E-02,  7.110494E-01,
     1     7.497539E-05,  1.534705E-06,  9.885523E-08,  7.660895E-05,
     1     4.313924E-02,  2.516133E-02,  4.048428E+00,  1.223070E+00,
     1     1.807759E+01,
     1     1.238558E+00,  4.740364E-01,  3.592723E-02,  1.748521E+00,
     1     2.134127E-01,  1.028021E-01,  6.186708E-03,  3.224015E-01,
     1     3.193569E-04,  9.257968E-07,  5.979543E-08,  3.203425E-04,
     1     1.923387E-01,  1.096654E-01,  1.856199E+00,  4.123880E-01,
     1     6.410515E+00,
     1     6.423070E-01,  1.523312E-01,  8.869353E-03,  8.035075E-01,
     1     8.335815E-02,  3.327694E-02,  1.653060E-03,  1.182882E-01,
     1     1.289154E-03, -2.187841E-06, -1.410750E-07,  1.286825E-03,
     1     5.809810E-01,  2.953382E-01,  4.384880E-01,  5.502951E-02,
     1     1.104450E+00,
     1     3.995610E-01,  1.795575E-02,  4.407810E-04,  4.179575E-01,
     1     2.301353E-02,  3.468075E-03,  7.905831E-05,  2.656066E-02,
     1     3.636153E-03, -1.691444E-06, -1.094519E-07,  3.634352E-03,
     1     4.561589E-01,  1.770018E-01,  5.062598E-02,  4.458013E-03,
     1     1.403667E-01,
     1     2.354978E-01,  1.286867E-03,  1.607580E-05,  2.368007E-01,
     1     6.772414E-03,  1.577137E-04,  1.107169E-06,  6.931235E-03,
     1     2.929828E-03, -2.396961E-07, -1.558730E-08,  2.929573E-03,
     1     1.872641E-01,  5.126992E-02,  4.097507E-03,  3.204371E-04,
     1     1.631027E-02,
     1     9.968665E-02,  9.077004E-05,  1.705720E-06,  9.977913E-02,
     1     1.632681E-03,  5.397222E-06,  4.428611E-08,  1.638122E-03,
     1     1.293479E-03, -2.727283E-08, -1.774266E-09,  1.293450E-03,
     1     3.796242E-02,  6.170205E-03,  1.134424E-04,  9.245070E-06,
     1     9.195681E-04,
     1     2.327397E-02,  2.916880E-06,  9.200687E-08,  2.327698E-02,
     1     1.868415E-04,  4.896462E-08,  8.962793E-10,  1.868914E-04,
     1     3.004704E-04, -1.465172E-09, -9.586952E-11,  3.004688E-04,
     1     9.480294E-04,  5.099695E-05,  7.581687E-08,  9.451960E-09,
     1     3.918338E-06,
     1     8.612141E-04,  3.980467E-09,  3.746194E-10,  8.612184E-04,
     1     1.693994E-06,  6.831281E-12,  7.535237E-13,  1.694001E-06,
     1     1.086137E-05, -4.910571E-12, -3.030964E-13,  1.086136E-05,
     1     1.394600E-01,
     1     2.604842E-03,  1.607062E-03,  2.424491E+01,  1.060348E+01,
     1     1.450155E+02,
     1     7.745659E+00,  4.548972E+00,  7.811260E-01,  1.307576E+01,
     1     1.274970E+00,  8.094015E-01,  1.625055E-01,  2.246877E+00,
     1     1.980266E-04,  1.008031E-05,  1.451002E-06,  2.095579E-04,
     1     1.175665E-02,  6.980479E-03,  1.178463E+01,  4.786239E+00,
     1     6.467983E+01,
     1     3.731985E+00,  2.037785E+00,  3.319515E-01,  6.101722E+00,
     1     5.772665E-01,  3.587954E-01,  7.027011E-02,  1.006332E+00,
     1     8.328198E-04,  1.669187E-05,  2.403359E-06,  8.519150E-04,
     1     5.229958E-02,  3.025818E-02,  5.303096E+00,  1.873904E+00,
     1     2.480222E+01,
     1     1.681619E+00,  7.796927E-01,  1.190119E-01,  2.580323E+00,
     1     2.266049E-01,  1.350105E-01,  2.561669E-02,  3.872320E-01,
     1     3.441665E-03,  8.060445E-06,  1.164314E-06,  3.450890E-03,
     1     2.150235E-01,  1.212482E-01,  2.100131E+00,  5.591278E-01,
     1     7.286525E+00,
     1     7.499243E-01,  2.276773E-01,  3.060342E-02,  1.008205E+00,
     1     7.167582E-02,  3.696330E-02,  6.674145E-03,  1.153133E-01,
     1     1.317426E-02, -2.511263E-05, -3.619901E-06,  1.314553E-02,
     1     5.656651E-01,  2.821564E-01,  4.102433E-01,  6.183702E-02,
     1     9.649397E-01,
     1     3.947862E-01,  2.415826E-02,  2.416752E-03,  4.213612E-01,
     1     1.576716E-02,  3.184673E-03,  5.015833E-04,  1.945341E-02,
     1     3.297578E-02, -1.609376E-05, -2.327398E-06,  3.295736E-02,
     1     3.925024E-01,  1.484172E-01,  4.110900E-02,  4.298394E-03,
     1     1.018794E-01,
     1     2.052105E-01,  1.647367E-03,  1.168594E-04,  2.069748E-01,
     1     4.132174E-03,  1.473844E-04,  1.795840E-05,  4.297517E-03,
     1     2.317946E-02, -1.996399E-06, -2.899033E-07,  2.317717E-02,
     1     1.457222E-01,  3.871874E-02,  2.993343E-03,  2.758751E-04,
     1     1.063916E-02,
     1     7.698680E-02,  1.075020E-04,  5.719453E-06,  7.710002E-02,
     1     8.945242E-04,  6.217648E-06,  5.224517E-07,  9.012643E-04,
     1     9.021676E-03, -2.021173E-07, -2.932669E-08,  9.021444E-03,
     1     2.630571E-02,  4.132118E-03,  7.380911E-05,  7.007634E-06,
     1     5.526199E-04,
     1     1.543201E-02,  2.834740E-06,  1.264216E-07,  1.543497E-02,
     1     8.961228E-05,  9.129481E-08,  3.737669E-09,  8.970732E-05,
     1     1.794882E-03, -9.461272E-09, -1.366263E-09,  1.794871E-03,
     1     5.331486E-04,  2.767911E-05,  4.067031E-08,  5.749530E-09,
     1     2.019064E-06,
     1     4.260216E-04,  2.205101E-09,  2.118971E-10,  4.260240E-04,
     1     6.443325E-07,  7.238584E-12,  3.953842E-13,  6.443401E-07,
     1     4.856949E-05, -2.313013E-11, -3.266819E-12,  4.856946E-05,
     1     1.156048E-01,
     1     3.190836E-03,  1.953247E-03,  3.473258E+01,  1.587455E+01,
     1     2.201177E+02,
     1     1.388788E+01,  7.509461E+00,  2.127120E+00,  2.352446E+01,
     1     1.967157E+00,  1.133481E+00,  3.759921E-01,  3.476630E+00,
     1     1.216987E-03,  5.842237E-05,  1.032672E-05,  1.285736E-03,
     1     1.402360E-02,  8.275068E-03,  1.561758E+01,  6.724423E+00,
     1     8.880430E+01,
     1     6.196152E+00,  3.163525E+00,  8.588456E-01,  1.021852E+01,
     1     7.990587E-01,  4.549534E-01,  1.492077E-01,  1.403220E+00,
     1     5.036879E-03,  9.210426E-05,  1.628659E-05,  5.145269E-03,
     1     6.001981E-02,  3.451947E-02,  6.417382E+00,  2.449402E+00,
     1     3.040430E+01,
     1     2.543755E+00,  1.144803E+00,  2.901389E-01,  3.978697E+00,
     1     2.770198E-01,  1.528742E-01,  4.936234E-02,  4.792564E-01,
     1     2.030649E-02,  3.556791E-05,  6.313339E-06,  2.034837E-02,
     1     2.324380E-01,  1.299974E-01,  2.277848E+00,  6.674870E-01,
     1     7.791337E+00,
     1     1.003767E+00,  3.087610E-01,  7.035033E-02,  1.382878E+00,
     1     7.519275E-02,  3.640917E-02,  1.147385E-02,  1.230758E-01,
     1     7.436343E-02, -1.437377E-04, -2.544640E-05,  7.419424E-02,
     1     5.499397E-01,  2.703570E-01,  3.852689E-01,  6.446950E-02,
     1     8.526991E-01,
     1     4.497348E-01,  2.932945E-02,  5.430806E-03,  4.844950E-01,
     1     1.370115E-02,  2.582627E-03,  7.807236E-04,  1.706450E-02,
     1     1.688360E-01, -8.001085E-05, -1.421033E-05,  1.687418E-01,
     1     3.462267E-01,  1.283300E-01,  3.460208E-02,  4.014238E-03,
     1     7.890020E-02,
     1     2.073648E-01,  1.847658E-03,  2.820858E-04,  2.094945E-01,
     1     3.186824E-03,  1.072643E-04,  3.084640E-05,  3.324935E-03,
     1     1.065709E-01, -8.960165E-06, -1.597925E-06,  1.065603E-01,
     1     1.186825E-01,  3.081159E-02,  2.320056E-03,  2.376098E-04,
     1     7.639940E-03,
     1     7.012370E-02,  1.129682E-04,  1.499369E-05,  7.025167E-02,
     1     6.241731E-04,  4.417203E-06,  1.191305E-06,  6.297817E-04,
     1     3.763726E-02, -8.292541E-07, -1.477832E-07,  3.763628E-02,
     1     1.953016E-02,  2.988066E-03,  5.234923E-05,  5.558322E-06,
     1     3.709720E-04,
     1     1.239870E-02,  2.776401E-06,  3.235158E-07,  1.240180E-02,
     1     5.565310E-05,  6.967883E-08,  1.625297E-08,  5.573904E-05,
     1     6.653342E-03, -3.405429E-08, -6.152110E-09,  6.653302E-03,
     1     3.352261E-04,  1.693315E-05,  2.487667E-08,  3.907878E-09,
     1     1.171635E-06,
     1     2.717833E-04,  2.019064E-09,  2.686954E-10,  2.717855E-04,
     1     3.289261E-07,  2.508748E-11,  1.262383E-12,  3.289524E-07,
     1     1.441384E-04, -7.116949E-11, -1.186038E-11,  1.441383E-04/
*
      call getapfelversion(apfelversion)
      write(6,*) achar(27)//"[34m"
      write(6,*) "Checking APFEL v",apfelversion," ...",achar(27)//"[0m"
*
*     Settings
*
c      call EnableWelcomeMessage(.false.)
      call SetMassScheme("FONLL-C")
      call SetProcessDIS("NC")
*
*     Initializes integrals on the grids
*
      call InitializeAPFEL_DIS
*
*     Compare the output with the reference
*
      Q0   = dsqrt(Q20) - eps
      iref = 0
      succ = .true.
      do iQ=1,4
         Q = dsqrt(Q2(iQ))
         call ComputeStructureFunctionsAPFEL(Q0,Q)
*     alpha_s
         iref = iref + 1
         if((Ref(iref)-AlphaQCD(Q))/Ref(iref).gt.toll)
     1        succ = .false.
*     PDF evolution
         do ilha=1,9
            iref = iref + 1
            if((Ref(iref)-(xPDFj(2,xlha(ilha))-xPDFj(-2,xlha(ilha))))
     1           /Ref(iref).gt.toll) succ = .false.
            iref = iref + 1
            if((Ref(iref)-(xPDFj(1,xlha(ilha))-xPDFj(-1,xlha(ilha))))
     1           /Ref(iref).gt.toll) succ = .false.
            iref = iref + 1
            if((Ref(iref)-2d0*(xPDFj(-1,xlha(ilha))
     1           +xPDFj(-2,xlha(ilha))))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-(xPDFj(4,xlha(ilha))+xPDFj(-4,xlha(ilha))))
     1           /Ref(iref).gt.toll) succ = .false.
            iref = iref + 1
            if((Ref(iref)-xPDFj(0,xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
*     F_2
            iref = iref + 1
            if((Ref(iref)-F2light(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F2charm(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F2bottom(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F2total(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
*     F_L
            iref = iref + 1
            if((Ref(iref)-FLlight(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-FLcharm(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-FLbottom(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-FLtotal(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
*     F_3
            iref = iref + 1
            if((Ref(iref)-F3light(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F3charm(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F3bottom(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
            iref = iref + 1
            if((Ref(iref)-F3total(xlha(ilha)))/Ref(iref).gt.toll)
     1           succ = .false.
         enddo
      enddo
*
      if(succ)then
         write(6,*) "Check ... ",
     1        achar(27)//"[1;32m","succeded",achar(27)//"[0m"
      else
         write(6,*) "Check ... ",
     1        achar(27)//"[1;31m","failed",achar(27)//"[0m"
      endif
      write(6,*)
      CheckAPFEL = succ
*
*     Code to write the reference table
*
c$$$      Q0 = dsqrt(Q20) - eps
c$$$      write(6,'(a)') "      data Ref /"
c$$$      do iQ=1,4
c$$$         Q = dsqrt(Q2(iQ))
c$$$         call ComputeStructureFunctionsAPFEL(Q0,Q)
c$$$*     alpha_s
c$$$         write(6,'(a,es14.6,a)') "     1   ",AlphaQCD(Q),","
c$$$*     PDF evolution
c$$$         do ilha=1,9
c$$$            write(6,'(a,4(es14.6,a))') "     1   ",
c$$$     1           xPDFj(2,xlha(ilha)) - xPDFj(-2,xlha(ilha)),",",
c$$$     2           xPDFj(1,xlha(ilha)) - xPDFj(-1,xlha(ilha)),",",
c$$$     3           2d0*(xPDFj(-1,xlha(ilha)) + xPDFj(-2,xlha(ilha))),",",
c$$$     4           xPDFj(4,xlha(ilha)) + xPDFj(-4,xlha(ilha)),","
c$$$            write(6,'(a,es14.6,a)') "     1   ",
c$$$     1           xPDFj(0,xlha(ilha)),","
c$$$*     F_2
c$$$            write(6,'(a,4(es14.6,a))') "     1   ",
c$$$     1           F2light(xlha(ilha)),",",
c$$$     2           F2charm(xlha(ilha)),",",
c$$$     3           F2bottom(xlha(ilha)),",",
c$$$     4           F2total(xlha(ilha)),","
c$$$*     F_L
c$$$            write(6,'(a,4(es14.6,a))') "     1   ",
c$$$     1           FLlight(xlha(ilha)),",",
c$$$     2           FLcharm(xlha(ilha)),",",
c$$$     3           FLbottom(xlha(ilha)),",",
c$$$     4           FLtotal(xlha(ilha)),","
c$$$*     F_3
c$$$            write(6,'(a,4(es14.6,a))') "     1   ",
c$$$     1           F3light(xlha(ilha)),",",
c$$$     2           F3charm(xlha(ilha)),",",
c$$$     3           F3bottom(xlha(ilha)),",",
c$$$     4           F3total(xlha(ilha)),","
c$$$         enddo
c$$$      enddo
c$$$      write(6,'(a)') "      /"
*
      return
      end

