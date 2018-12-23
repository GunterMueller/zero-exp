set terminal cairolatex standalone pdf size 8.5cm,3.3cm dashed transparent font "default,8" \
    header "\\usepackage{xcolor}"
set output "fl_logging.tex"
#set datafile separator "\t"

set style line 11 lc rgb '#808080' lt 1
set border 11 back ls 11
set style line 12 lc rgb '#444444' lt 0 lw 1
set grid back ls 12
set style fill transparent solid 0.5 border

# line styles for ColorBrewer Dark2
# for use with qualitative/categorical data
# provides 8 dark colors based on Set2
# compatible with gnuplot >=4.2
# author: Anna Schneider

# line styles
set style line 1 lw 3 lc rgb '#1B9E77' # dark teal
set style line 2 lw 3 lc rgb '#D95F02' # dark orange
set style line 3 lw 3 lc rgb '#7570B3' # dark lilac
set style line 4 lw 3 lc rgb '#E7298A' # dark magenta
set style line 5 lw 3 lc rgb '#66A61E' # dark lime green
set style line 6 lw 3 lc rgb '#E6AB02' # dark banana
set style line 7 lw 3 lc rgb '#A6761D' # dark tan
set style line 8 lw 3 lc rgb '#666666' # dark gray

# palette
set palette maxcolors 8
set palette defined ( 0 '#1B9E77',\
    	    	      1 '#D95F02',\
		      2 '#7570B3',\
		      3 '#E7298A',\
		      4 '#66A61E',\
		      5 '#E6AB02',\
		      6 '#A6761D',\
		      7 '#666666' )

set lmargin 14
set rmargin 1
set bmargin 3
set key off

file = dir."/fl_logging.txt"

set multiplot layout 1, 2 ;

set boxwidth 0.7 
set style fill solid 0.5

set xtics offset 0,-0.5
set ylabel "Log bytes / txn." offset -5
set xrange [-1:2]
set yrange [0:6500]
plot file using (column(0)==0 ? $0 : 1/0):2:xtic(1) with boxes notitle ls 1, \
    '' using (column(0)==1 ? $0 : 1/0):2:xtic(1) with boxes notitle ls 2, \
    '' using 0:2:(sprintf("%.2f",$2)) with labels center offset 0,0.7

set xtics offset 0,-0.5
set ylabel "Log inserts / txn." offset -3
set yrange [0:15.5]
plot file using (column(0)==0 ? $0 : 1/0):3:xtic(1) with boxes notitle ls 1, \
    '' using (column(0)==1 ? $0 : 1/0):3:xtic(1) with boxes notitle ls 2, \
    '' using 0:3:(sprintf("%.2f",$3)) with labels center offset 0,0.7

