
%col=unifrnd(0,1,6,3);
load col.mat
load pop1_pop2.mat
subplot(2,1,1)
plot(ma(:,1),ma(:,2),"LineWidth",2,"Color",col(1,:));
ylabel("Pi")
hold on 
plot(ma(:,1),ma(:,3),"LineWidth",2,"Color",col(2,:));
%set(gca,'TickDir','in');
%set(gca,'TickLength',[0.005,0.1]);
set(gca,'FontName','Times New Roman', 'FontWeight','bold','FontSize',14);
set(gca,'xtick',[])
legend("Pi (pop1)","Pi(pop2)","Orientation","horizontal")
subplot(2,1,2)
plot(ma(:,1),ma(:,4),"LineWidth",2,"Color",col(3,:))
ylabel("Fst")
hold on 
stem(ma(:,1),ones(length(ma(:,1)),1)/10,"LineWidth",1,"Color",col(4,:),"Marker","none")
set(gca,'FontName','Times New Roman', 'FontWeight','bold','FontSize',14);
hold on
label=["EDN3";"ATP5E";"LOC101747896";"SLMO2"];
xl=[11004803	0.5
11088134	0.5
11079256	0.5
11074141	0.5
];
for i =1:4
text(xl(i,1),xl(i,2),label(i),...
	 'Color',col(4,:),'FontSize',9,'HorizontalAlignment','center',...
	 'VerticalAlignment','bottom','FontName','Times New Roman','FontWeight','bold','FontSize',18);
end


