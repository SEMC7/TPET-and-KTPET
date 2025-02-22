function final_data = KTPET_test_process(data_test,data_train,X_all,k,mu,trans_vec,gamma,k_type)
%Function to convert test set samples to envelope samples using KTPET
%The data_test and data_train contains label information.
%X_all, mu, trans_vec can be found in the output of function KTPET_train_process.
%k is the number of nearest neighbor samples plus 1.
%gamma is the parameter of the Gaussian kernel function.
%k_type is kernel function type.
    
    a = size(data_test,1);
    data_testX = data_test(:,1:end-1);
    data_testY = data_test(:,end);
    data_trainX = data_train(:,1:end-1);
    
    D_matrix = get_distance_matrix(data_testX,data_trainX);
    [~,index] = sort(D_matrix,2);
    
    trans_data = [];
    
    for i = 1:a
        
        temp_vec = data_testX(i,:);
        
        for j=1:k-1
            
            temp_vec = [temp_vec;data_trainX(index(i,j),:)];
            
        end
        
        trans_data = [trans_data;temp_vec'];
            
    end
    
    trans_data = trans_vec'*kernel_matrix(X_all,trans_data,gamma,k_type)-mu*ones(1,size(trans_data,1));
    trans_data = trans_data';
    
    dim = size(data_testX,2);
    
    temp_data = zeros(a,dim);
    
    for i = 1:a
        
        temp_data(i,:) =  trans_data((i-1)*dim+1:i*dim,1)';
        
    end

    final_data = [temp_data,data_testY];

end