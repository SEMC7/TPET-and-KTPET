function [trans_vec,center_vec] = kpca(data,sigma,k_type)

    N = size(data,1);
    k_matrix = kernel_matrix(data,data,sigma,k_type);
    k_matrix_ori = k_matrix;
    k_matrix = optimization_cal_matrix(k_matrix);
                          
    [U,D] = eigs(k_matrix,1,'lm','MaxIterations',100000);

     trans_vec = U/(D^0.5);
    
    center_vec = trans_vec'*k_matrix_ori*ones(N,1)*(1/N);
    
end