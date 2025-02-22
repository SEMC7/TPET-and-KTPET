function final_data = TPET_test_process(data_test,data_train,k,mu,trans_vec)
%Function to convert test set samples to envelope samples using TPET
%The data_test and data_train contains label information.
%mu, trans_vec can be found in the output of function TPET_train_process.
%k is the number of nearest neighbor samples plus 1.
    
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
    
    trans_data = bsxfun(@minus, trans_data, mu);
    trans_data = trans_data*trans_vec;
    
    dim = size(data_testX,2);
    
    temp_data = zeros(a,dim);
    
    for i = 1:a
        
        temp_data(i,:) =  trans_data((i-1)*dim+1:i*dim,1)';
        
    end

    final_data = [temp_data,data_testY];

end