function handleData33( data, params)
% PROCESSDATA( PROCPARMS, SIMUPARMS)

% if ~exist( 'data','var')
%     error( 'Please input processing parameters');
% end
% if ~exist( 'params','var')
%     error( 'Please input simulation parameters');
% end

% if isempty(data.writeData)
%     return
% end

method = data.method;
[success wrnmsg wrnmsgID] = mkdir(data.writedir,data.str);

for i=1:length(data.writeData)

    [success wrnmsg wrnmsgID] = mkdir(data.writedir1{i}, data.writedirChild1{i});
    [success wrnmsg wrnmsgID] = mkdir(data.writedir2{i}, data.writedirChild2{i});
    [success wrnmsg wrnmsgID] = mkdir(data.writedir3{i}, data.writedirChild3{i});

    switch method
        case 'separate'
            processImage3( data.pathData{i}, data.writeData{i}, params);
        case 'featcalc'
            calculateFeatures2( data.pathData{i}, data.writeData{i}, params.featCalc.FEATSET, params.featCalc.NLEVELS, params);
        case 'classification'
            classifyPatterns(data,params.classify.CMETHOD,params.featCalc.FEATSET,params.featCalc.FEATTYPE,params.separate.UMETHOD);
        case 'prediction'
            [success wrnmsg wrnmsgID] = mkdir(data.writedir4{i}, data.writedirChild4{i});
            predict( data.pathData{i}, data.writeData{i}, data.pathClassifier,params.classify.CMETHOD,params.predict.CLASS);
        case 'results'
            results( data.pathData{i},data.writeData{i},params.predict.CLASS,params.getResults.T);
        case 'parse'
            imageStats( data.pathData{i}, data.writeData{i});
        otherwise
            error( 'not supported yet');
    end
end
