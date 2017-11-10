

determL <- function(typeL, m, n, k ) {
  # returns a deterministic L Matrix as described in Ledermann et al (2011)
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
  if (!any(typeL==c('Ledermann', 'TypeI','TypeII', 'TypeIII','Type I','Type II','Type III','I','II', 'III'))) {  stop(sprintf("unkown type %s for type of deterministic L Matrix", typeL))}
  if (nargs() < 3) {stop("not enough input arguments")}
  if (!m%%1==0) {stop(sprintf("%f is not an integer value", m))}
  if (!n%%1==0) {stop(sprintf("%f is not an integer value", n))}
  
  if (typeL %in% c('Ledermann')){
    v = matrix(0, m, m-1)
    for (c in 1:m-1) {
      v[c,c] = 1
      v[c+1,c] = -1
    }
  }
  else if (typeL %in% c('TypeI', 'Type I', 'I')){
    
  }
  else if (typeL %in% c('TypeII', 'Type II', 'II')){
    
  }
  else if (typeL %in% c('TypeIII', 'Type III', 'III')){
    
  }
  return(v)
}



