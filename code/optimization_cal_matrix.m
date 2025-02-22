function final_matrix = optimization_cal_matrix(data)

    dim = size(data,1);
    row_vec = (1/dim)*sum(data,1);
    col_vec = (1/dim)*sum(data,2);
    
    temp1 =  repmat( row_vec , dim , 1 );
    temp2 =  repmat( col_vec , 1 , dim );
    
    temp_num = (1/dim/dim)*(sum(sum(data,1),2));
    
    temp3 =  repmat( temp_num , dim , dim );
    
    final_matrix = data - temp1 - temp2 + temp3;


end