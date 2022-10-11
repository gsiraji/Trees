function G = findFlowsTree(G,mu, varargin)

switch nargin
    case 1
        mu = 1.81e-5;
end

El = numedges(G);
Flow = ones(El,1);
edgeShear = ones(El,1);
for ed =1:1:El
    twonodes = (G.Edges.EndNodes(ed,:));
    twonodes_x = G.Nodes(twonodes,:).X;
    [~, max_x_idx] = max(twonodes_x);

    edgeFlow  = (G.Nodes.Potentials(twonodes([1,2] ~= max_x_idx)) - G.Nodes.Potentials(twonodes(max_x_idx)))./G.Edges.Resistances(ed);
   
    Flow(ed) = edgeFlow;
    edgeShear(ed) = abs(edgeFlow*32*mu/(pi*(G.Edges.Widths(ed,1))^3)); % tau_w = 4*mu*q/pi r^3
    %     lambda = 24./((1-0.351.*edge_thic(ed)./depth).*(1+edge_thic(ed)./depth)).^2;
%     edgeShear_rate2(ed) = abs(ed_col.^2.*res_vec(ed).*lambda./(8*(edge_thic(ed).*depth)^2));
    G.Edges.Flow = Flow;
    G.Edges.Shear = edgeShear;
end
end