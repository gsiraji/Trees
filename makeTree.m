
Gens = 6;
A = zeros(2^Gens);
for i = 2:2^(Gens-1)   
    A(i,2*i) = 1;
    A(i,2*i-1)=1;
    A(2*i,i) = 1;
    A(2*i-1,i)=1;
end
A(1,2) = 1;
A(2,1) = 1;
G = graph(A);
G.Nodes.ID = [1:2^Gens]';
%%
G.Edges.Resistances = ones(numedges(G),1);
pathsG = distances(G);
% pathsFrom1 = pathsG(1,:);
G.Nodes.X = pathsG(1,:)';
G.Edges.Widths = 1./(G.Nodes.X(G.Edges.EndNodes(:,1))+1);
%%
G = potSolverTree(G,10,Gens);
%%
G = findFlowsTree(G);
%%
p = plot(G,'Layout','layered');

% p.XData = G.Nodes.X;
% p.YData = mod(G.Nodes.ID,G.Nodes.X);

p.Marker = 'none'
% p.NodeCData = G.Nodes.X;
p.EdgeCData = G.Edges.Flow;
p.LineWidth = G.Edges.Widths.*10;