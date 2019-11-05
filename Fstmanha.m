
function Fstmanha (chr, pos, score,lightpos,snps)
	%Fstmanha (chr, pos, score,lightpos,snps)
 	% Alternating shades for chromosomes.
  	%clr1 = rgb('midnightblue');
  	%clr2 = rgb('cornflowerblue');
	%clr1=unifrnd(0,1,1,3);
	%clr2=unifrnd(0,11,3);
  	% These are the SNPs to highlight in the Manhattan plot.
  % Get the set of chromosomes represented by the SNPs.
  chrs = unique(chr);
  chrs = chrs(:)';
  
  % This is the current position in the plot.
	p0 = 0;

  % Repeat for each chromosome.
  hold on
  for c = chrs
    
    % Plot the SNPs on the chromosome.
    is = find(chr == c);
    maxpos = max(pos(is));
    cl=unifrnd(0,1,50,3);
   % save cl.mat cl
   % load cl.mat
    %cl=load('colorchrhg.txt');
   % cln=randperm(24);cl=cl(cln,:);
    if ~isodd(c)
      %clr = unifrnd(0,1,1,3);
      clr=cl(c,:);
    else
      %clr = unifrnd(0,1,1,3);
      clr=cl(c,:);
    end
    bar(p0+pos(is),score(is),'FaceColor',clr,'EdgeColor',clr)
   % plot(p0 + pos(is),score(is),'o','MarkerFaceColor',clr,...
	% 'MarkerEdgeColor','none','MarkerSize',4);

    % Highlight these SNPs.
    %is = find(chr(snps) == c);
   % if isodd(c)
    %  clr = rgb('forestgreen');
   % else
    %  clr = rgb('yellowgreen');
    %end
   % if length(is)
     %  bar(pos(snps(is)),score(snps(is)),'FaceColor',clr,'EdgeColor',clr)
      %plot(p0 + pos(snps(is)),score(snps(is)),'o','MarkerFaceColor',clr,...
	 %  'MarkerEdgeColor','none','MarkerSize',4);    
   % end
       
    nsnp=find(lightpos(:,1)==c);
    if ~isempty(nsnp)
        sm=0.005:0.005:1;
        for il=1:length(nsnp)
            
            text(p0+lightpos(nsnp(il),2),max(score(is))+sm(il),snps{nsnp(il)},...
                'Color',[0 0 0],'FontSize',9,'HorizontalAlignment','center',...
                'VerticalAlignment','bottom','FontName','Times New Roman','FontWeight','bold','FontSize',12);
        end
        %annotation('textarrow',p0+lightpos(nsnp,2),0.6,'String',snps(nsnp))
    
    end
   
    % Add the chromosome number.
    %for il=1:nchr
    text(p0 + maxpos/2,-0.075 * (max(score) - min(score)),num2str(c),...
	 'Color',cl(c,:),'FontSize',9,'HorizontalAlignment','center',...
	 'VerticalAlignment','bottom','FontName','Times New Roman','FontWeight','bold','FontSize',18);
    %end

    % Move to the next chromosome.
    p0 = p0 + maxpos+4000000;
  end
  hold off
  set(gca,'XLim',[0 p0],'XTick',[],'YLim',[0 1]);
  set(gca,'TickDir','in','TickLength',[0.000003 0.000003]);
