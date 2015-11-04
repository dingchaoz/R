library(R.matlab)

con <- 'F_SL053_0721_Alpha_141201.mat'

data <- readMat(con,maxLength=NULL, fixNames=TRUE, drop=c("singletonLists"),sparseMatrixClass=c("Matrix", "SparseM", "matrix"))

#readMat(con, maxLength=NULL, fixNames=TRUE, drop=c("singletonLists"),
#         sparseMatrixClass=c("Matrix", "SparseM", "matrix"), verbose=FALSE)
