function D_matrix = get_distance_matrix(data1,data2)

    data1_row_sum = sum(data1.*data1,2);
    data2_row_sum = sum(data2.*data2,2);

    data_cross = data1*data2';

    D_matrix = bsxfun(@plus,data1_row_sum,data2_row_sum') - 2*data_cross;

end
