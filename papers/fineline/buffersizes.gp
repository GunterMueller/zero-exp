set terminal cairolatex standalone pdf size 8.5cm,4cm dashed transparent font "default,8" \
    header "\\usepackage{xcolor}"
set output "buffersizes.tex"
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

set lmargin 10
set rmargin 1
set bmargin 5
set key off

set key at 6,58 invert opaque samplen 2 width 2 spacing 2 

file = dir."/buffersizes.txt"

set multiplot layout 1, 2 ;

set boxwidth 0.7 
set style fill solid 0.5

set xtics offset 0,-1
set xlabel "Buffer size (GB)" offset 0,-1.3
set yrange [0:60]
set ylabel "Throughput (ktps)" offset -3
plot file using 1:($3/1000):xtic(1) with boxes title "WAL" ls 1

set lmargin 2
set rmargin 9
set ylabel ''
set format y ''
set y2tics
plot file using 1:($2/1000):xtic(1) with boxes title "FineLine" ls 2
