function knn_matrix = find_knn(data,k)
    
    [a,~] = size(data);
    knn_matrix = zeros(a,k);
    D_matrix = get_distance_matrix(data,data);
    [~,index] = sort(D_matrix,2);
    
    for i = 1:a
        
        knn_matrix(i,:) = index(i,1:k);
        
    end

end