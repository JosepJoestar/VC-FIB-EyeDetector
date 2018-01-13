function [classifier] = svm(Tbl, Labels)
    c = cvpartition(size(Tbl, 1), 'KFold', 10);
    
    sigma = optimizableVariable('sigma', [1e-5, 1e5], 'Transform', 'log');
    box = optimizableVariable('box', [1e-5, 1e5], 'Transform', 'log');
    
    minfn = @(z)kfoldLoss(              ...
        fitcsvm(                        ...
            Tbl, Labels,                ...
            'CVPartition', c,           ...
            'KernelFunction', 'linear', ...
            'BoxConstraint',z.box,      ...
            'KernelScale', z.sigma));

    results = bayesopt(                   ...
        minfn, [sigma,box],               ...
        'IsObjectiveDeterministic', true, ...
        'AcquisitionFunctionName','expected-improvement-plus');
    
    z(1) = results.XAtMinObjective.sigma;
    z(2) = results.XAtMinObjective.box;
    
    classifier = fitcsvm(           ...
        cdata, grp,                 ...
        'KernelFunction','linear',  ...
        'KernelScale', z(1),        ...
        'BoxConstraint', z(2));
end
