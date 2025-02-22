function k_matrix = kernel_matrix(data1,data2,sigma,type_input)
    
    switch type_input
        
        case 'linear'
            
            k_matrix = data1*data2';
            
        case 'rbf'
            
            D_matrix = get_distance_matrix(data1,data2);
            k_matrix = exp((-D_matrix)/(2*sigma*sigma));
        
    end

end