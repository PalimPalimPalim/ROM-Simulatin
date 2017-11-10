#### deterministic L Matrices ####
determL <- function(typeL, m, n, k ) {
  # returns a deterministic L Matrix as described in Ledermann et al (2011)
  #
  # Steps:
  #   1. find pre image v
  #   2. get GS image w
  #   3. select n last columns of w
  # 
  # Example
  # ==========
  # l = detemL('Ledermann',10,2)
  # 
  # Parameters
  # ==========
  # m : int
  #   number of rows in l
  # n : int
  #   number of columns in l
  # k : int
  #   additional parameter for Type I,II,III L matrices
  # 
  # Output
  # ==========
  # l : numeric (two dimensional array)
  #   deterministic L Matrix
  
  ## Assertion
  if (!any(typeL==c('Ledermann', 'TypeI','TypeII', 'TypeIII','Type I','Type II','Type III','I','II', 'III'))) {  
    stop(sprintf("unkown type %s for type of deterministic L Matrix", typeL))}
  if (nargs() < 3) {
    stop("not enough input arguments")}
  if (!m%%1==0) {
    stop(sprintf("%f is not an integer value", m))}
  if (!n%%1==0) {
    stop(sprintf("%f is not an integer value", n))}
  if (!typeL=='Ledermann' & !nargs()==4){
    stop("L Matrices of Type I-III need an additional integer parameter k")}
  
  ## find pre-image
  # Ledermann
  if (typeL %in% c('Ledermann')){
    v = matrix(0, m, m-1)
    for (c in 1:m-1) {
      v[c,c] = 1
      v[c+1,c] = -1
    }
    
  # Type I
  } else if (typeL %in% c('TypeI', 'Type I', 'I')){
    if (!(2*k <= m+1-n)) {
      stop(" relation 2*k <= m+1-n not fullfilled see Ledermann 2011")
    }
    v <- matrix(0, m, m+1-2*k)
    for (c in 1:(m+1-2*k)) {
      v[c:(c+2*k-1), c] <- rep(c(1,-1),k)
    }
    
  # Type II  
  } else if (typeL %in% c('TypeII', 'Type II', 'II')){
    if (!(m-k >= n)) {
      stop(" relation m-k < n not fullfilled see Ledermann 2011")
    }
    v <- matrix(0, m, m-k)
    for (c in 1:(m-k)) {
      v[c:(c+k-1), c] <- rep(1,k)
      v[c+k, c] <- -k
    }
  # Type III  
  } else if (typeL %in% c('TypeIII', 'Type III', 'III')){
    if (!(m-2 >= n)) {
      stop(" relation m-2 >= n not fullfilled see Ledermann 2011")
    }
    v <- matrix(0, m, m-2)
    for (c in 1:(m-2)) {
      v[c, c] <- k
      v[c+1, c] <- -1
      v[c+2, c] <- 1-k
    }
  }
  
  ## get GS image w
  w <- gramSchmidt(l)$Q
  
  ## select n last columns of w
  return(w[ , (ncol(w)-(n-1)):ncol(w)])
}

#### data-specific L Matrices ####
dataL <- function(y) {
  # returns a data-specific L Matrix as described in Ledermann et al (2011)
  # Steps:
  #   1. de-mean
  #   2. orthogonalize with GS
  # 
  # Example
  # ==========
  #   l = dataL(y)
  # 
  # Parameters
  # ==========
  #   y : numeric (tow dimensional array)
  # original sample
  # 
  # Output
  # ==========
  #   l : numeric (two dimensional array)
  # data-specific L Matrix
  
  ## Assertion
  if (!ncol(y)<nrow(y)) {
    stop("Sample must have more rows (observations) than columns (risk factors)")}
  
  ## de-mean
  v <- y - matrix(apply(y, 2, mean),nrow(y),ncol(y),byrow=TRUE)
  
  ## orthogonalize with GS
  return(gramSchmidt(v)$Q)
}


