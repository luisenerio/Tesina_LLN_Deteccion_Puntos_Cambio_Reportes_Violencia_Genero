
#detección de punto de cambio



library(changepoint)

library(changepoint.np)



set.seed(1)
m1=c(rnorm(100,0,1),rnorm(100,.90,1))
m1.amoc=cpt.mean(m1)
cpts(m1.amoc)


plot(m1.amoc)




###
load('GPvisitsWeekNov1718.Rdata')
ts.plot(GPvisitsWeekNov1718)




####
  
  set.seed(5)
  v1=c(rnorm(100,0,1),rnorm(100,0,1.5),rnorm(100,0,2),
       rnorm(100,0,4))
  v1.man=cpt.var(v1,method='PELT',penalty='Manual',
                 pen.value='2*log(n)')
  cpts(v1.man)
  param.est(v1.man)
  
  
  plot(v1.man,cpt.width=3)
  
  
  
  
  ###
  set.seed(1)
  mv1=c(rexp(50,rate=1),rexp(50,5),rexp(50,2),rexp(50,7))
  mv1.pelt=cpt.meanvar(mv1,test.stat='Exponential',
                       method='BinSeg',Q=10,penalty="SIC")
  cpts(mv1.pelt)
  plot(mv1.pelt,cpt.width=3,cpt.col='blue')
  