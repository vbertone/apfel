************************************************************************
*
*     g1top.f:
*
*     This function returns the value of the inclusive structure function
*     g1.
*
************************************************************************
      function g1top(x)
*
      implicit none
*
      include "../commons/grid.h"
      include "../commons/StructureFunctions.h"
      include "../commons/TMC.h"
      include "../commons/Polarized.h"
**
*     Input Variables
*
      double precision x
**
*     Internal Variables
*
      integer n
      integer alpha
      double precision w_int_gen
* $$$      double precision tau,xi
* $$$      double precision c1,c2
      double precision tol
      parameter(tol=1d-10)
      double precision F3top
**
*     Output Variables
*
      double precision g1top
*
*
      if(Polarized)then
*      
         if(TMC)then
            write(6,*) "TMCs not available for polarised DIS"
            call exit(-10)
* $$$         tau = 1d0 + 4d0 * rhop * x**2
* $$$         xi  = 2d0 * x / ( 1d0 + dsqrt(tau) )
* $$$ *
* $$$         c1 = x**2 / xi**2 / tau
* $$$         c2 = 4d0 * rhop * x**3 / tau**1.5d0
* $$$ *
* $$$         if(xi.lt.xmin(1)-tol.or.xi.gt.xmax+tol)then
* $$$            write(6,*) "In F3top.f:"
* $$$            write(6,*) "Invalid value of x =",xi
* $$$            call exit(-10)
* $$$         endif
* $$$         if (xi.lt.xmin(1)) xi = xmin(1)
* $$$         if (xi.gt.xmax) xi = 1d0
* $$$ *
* $$$ *     Interpolation
* $$$ *
* $$$         F3top = 0d0
* $$$         n = inter_degree(0)
* $$$         do alpha=0,nin(0)
* $$$            F3top = F3top + w_int_gen(n,alpha,xi) 
* $$$     1           * ( c1 * F3(6,0,alpha) + c2 * I3(6,0,alpha) )
* $$$         enddo
* $$$         if(dabs(F3top).le.1d-14) F3top = 0d0
         else
            if(x.lt.xmin(1)-tol.or.x.gt.xmax+tol)then
               write(6,*) "In F3top.f:"
               write(6,*) "Invalid value of x =",x
               call exit(-10)
            endif
            if (x.lt.xmin(1)) x = xmin(1)
            if (x.gt.xmax) x = 1d0
*     
*     Interpolation
*     
            F3top = 0d0
            n = inter_degree(0)
            do alpha=0,nin(0)
               F3top = F3top + w_int_gen(n,alpha,x) * F3(6,0,alpha)
            enddo
            if(dabs(F3top).le.1d-14) F3top = 0d0
         endif
*     
         g1top = 1d0/2d0 * F3top
*     
      else
         write(6,*) "g1 structure function not available",
     1        " for unpolarised DIS"
         call exit(-10)
      endif         
*     
      return
      end
      
