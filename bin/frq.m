ln=hist(l2,5000);
ndist = ln/ sum(ln);
cdist = cumsum(ndist);
plot(cdist);
bar(fpi,ndist')

%x = randn(10000, 1);
numOfBins = 2000;
[histFreq, histXout] = hist(l2, numOfBins);

%bar(histXout, histFreq/sum(histFreq)*100);
%xlabel('x');
%ylabel('Frequency (percent)');
lm=histFreq/sum(histFreq)*100;
%for i=1:3
  %  if i==1
        bar(histXout(histXout >= quantile(histXout,0.04)), lm(histXout >= quantile(histXout,0.04)),'FaceColor','r','EdgeColor','r','LineWidth',0.001);
        hold on
    %elseif i==2
        bar(histXout(histXout <= quantile(histXout,0.04)), lm(histXout <= quantile(histXout,0.04)),'FaceColor','b','EdgeColor','b','LineWidth',0.001);
        hold on
    %else
        %bar(histXout(histXout >= quantile(histXout,0.9) & histXout <= quantile(histXout,0.1)),...
         %   lm(histXout >= quantile(histXout,0.9) & histXout <= quantile(histXout,0.1)),'FaceColor','r','EdgeColor','r','LineWidth',0.001);
       % hold on
    %end
%end
yyaxis right
lmc=cumsum(lm);
plot(histXout,lmc)
%x = randn(10000, 1);
numOfBins = 2000;
[histFreq, histXout] = hist(l1, numOfBins);

lm=histFreq/sum(histFreq)*100;%for i=1:2
   % if i==1
        bar(histXout(histXout >= quantile(histXout,0.1)), lm(histXout >= quantile(histXout,0.1)),'FaceColor','r','EdgeColor','r','LineWidth',0.001);
        hold on
   % elseif i==2
     %   bar(histXout(histXout <= quantile(histXout,0.05)), lm(histXout <= quantile(histXout,0.05)),'b');
       % hold on
    %else
         bar(histXout(histXout < quantile(histXout,0.1)), lm(histXout < quantile(histXout,0.1)),'FaceColor','b','EdgeColor','b','LineWidth',0.001);
       % hold on
    %end
%end
yyaxis right
lmc=cumsum(lm);
plot(histXout,lmc)

     bar(histXout(histXout >= quantile(histXout,0.2)), lm(histXout >= quantile(histXout,0.95)),'FaceColor','r','EdgeColor','r','LineWidth',0.001);
        hold on
   % elseif i==2
     %   bar(histXout(histXout <= quantile(histXout,0.05)), lm(histXout <= quantile(histXout,0.05)),'b');
       % hold on
    %else
         bar(histXout(histXout < quantile(histXout,0.95)), lm(histXout < quantile(histXout,0.95)),'FaceColor','b','EdgeColor','b','LineWidth',0.001);
       % hold on

plot()