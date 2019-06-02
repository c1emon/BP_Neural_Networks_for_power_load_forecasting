function main()

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    month = 12;  %训练月份
    day_start = 5; %开始日期
    day_len = 5;  %训练天数
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    file_path = '2018负荷预测数据';
    map_maxmin = [];
    output = [];

    for day = day_start:1:(day_start + day_len - 1)
        [raw_data, raw_max ,raw_min] = read_load_data_from_excel(file_path, month ,day);
        data_temp =  my_map(1, raw_data, raw_max, raw_min, 1, 0);
        map_maxmin = cat(1, map_maxmin, [0 1]);
        output = cat(1, output, data_temp);
        target_day = day + 1;
    end

    [target_data, target_max, target_min] = read_load_data_from_excel(file_path, month ,target_day);
    t_d =  my_map(1, target_data, target_max, target_min, 1, 0);

    net = newff(map_maxmin, [6,40,1], {'tansig','logsig','purelin'}, 'traincgf');

    net.trainParam.epochs = 1000000;%设置最大迭代次数
    net.trainParam.goal = 0.001;%设置神经网络的训练的目标误差
    net.trainParam.lr = 0.1;%学习率

    goal_net = train(net, output, t_d);%训练神经网络，返回训练好的网络和误差记录

    Y = sim(goal_net, output);
    goal = my_map(0, Y', target_max, target_min, 1, 0);
    
    t=1:1:96;
    plot(t,target_data,t,goal,'r')

    goal'

end

