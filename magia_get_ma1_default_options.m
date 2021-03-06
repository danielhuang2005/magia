function value = magia_get_ma1_default_options(tracer,var)

if(iscell(tracer))
    tracer = tracer{1};
end

switch tracer
    case '[18f]fmpep-d2'
        switch var
            case 'start_time'
                value = 42;
            case 'end_time'
                value = 0;
        end
    otherwise
        error('Default MA1 options have not been specified for %s.',tracer);
        
end