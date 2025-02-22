function [trans_data,mu,trans_vec,X_all_temp] = KTPET_train_process(data_set,k,gamma,k_type)
%Function to convert training set samples to envelope samples using KTPET.
%The data_set contains label information, starting at 0. (0, 1...)
%k is the number of nearest neighbor samples plus 1.
%gamma is the parameter of the Gaussian kernel function.
%k_type is kernel function type.


    dataY = data_set(:,end);
    data_feature = data_set(:,1:end-1);
    class_name = unique(dataY);
    category_num = length(class_name);
    X_all = [];
    X_all_label = [];
    
    for q = 1:category_num
        
        X_near = [];
        data_temp = data_feature(find(dataY == (q-1)),:);
        data_num = size(data_temp,1);
        knn_matrix = find_knn(data_temp,k);
        
        for i=1:data_num
                
            temp_vec = [];

            for j=1:k

                temp_vec = [temp_vec;data_temp(knn_matrix(i,j),:)];

            end
        
            X_near = [X_near;temp_vec'];

        end
        
        X_all = [X_all;X_near];
        X_all_label = [X_all_label;(q-1)*ones(data_num,1)];
        
    end
    
    %¶ÔX_all×÷pca
    
    [trans_vec,mu] = kpca(X_all,gamma,k_type);
    X_all_temp = X_all;
    X_all = trans_vec'*kernel_matrix(X_all,X_all,gamma,k_type)-mu*ones(1,size(X_all,1));
    X_all = X_all';
    
    
    total_num = size(data_set,1);
    dim = size(data_feature,2);
    final_data =zeros(total_num,dim);
    
    for i = 1:total_num
        
        final_data(i,:) =  X_all((i-1)*dim+1:i*dim,1)';
        
    end
    
    
    trans_data = [final_data,X_all_label];
    
      
end
