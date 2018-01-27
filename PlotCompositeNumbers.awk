BEGIN {
  max=50

  tmp="PlotCompositeNumbers"
  tmpA=tmp "_A.tmp"
  tmpB=tmp "_B.tmp"

  #Guide Line
  size=0
  color=255 #BLUE
  for(x=1;x<=max;x=x+2) {
    printf("%d,%d,%f,%d\n",1,x, size, -1) > tmpA
    printf("%d,%d,%f,%d\n",x,1, size, color) > tmpA
  }

  #Composite numbers
  size=0.8
  color=255*2^16 #RED
  for(x=1;x<=max;x=x+2) {
    for(y=1;(xy=x*y)<=max;y=y+2) {
      printf("%d,%d,%f,%d,%d\n",x,y, size, color,xy) > tmpB
    }
  }

  #gnuplot command
  printf("set term 'windows'\n")
  printf("set size ratio -1\n")
  printf("set xrange [%f:%f]\n",1,max)
  printf("set yrange [%f:%f]\n",1,max)
  printf("set logscale xy\n")
  printf("set xzeroaxis\n")
  printf("set yzeroaxis\n")
  printf("set grid xtics,ytics,mxtics,mytics\n")
  printf("set datafile separator \",\"\n")
  printf("plot '%s' using 1:2:3:4 with lp lw 0 ps variable lc rgb variable notitle, '%s' using 1:2:3:4 with points pt 7 ps variable lc rgb variable notitle, '' using 1:2:5 with labels left offset 0.5 rotate by 60 notitle\n",tmpA,tmpB)
}
