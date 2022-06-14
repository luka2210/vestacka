function [searchNodes,iterations] = dfs(source,target,names,startNode)
%    DFS performs depth first search on graph with source and target
%    vectors.
%     
%    Syntax:     
%          
%    [searchNodes,iterations] = dfs(source,target,names,startNode)
%    [searchNodes,iterations] = dfs(source,target,startNode)
%    
%    Inputs:
%
%    source = Vector or cell array containing starting node of each of the edge.
%    target = Vector or cell array containing ending node of each of the edge.
%    names = Cell array containing string names of each of the node.
%    startNode = Initial node in the graph.
%    
%    Outputs:
%
%    path = Cell array containing search path.
%    iterations = Table containing dfs iteration summary.
% 
%    Example 01:
%     
%    s = {'A','A','A','B','B','C'};
%    t = {'B','C','D','E','F','G'};
%    [searchNodes,iterations] = dfs(s,t,'A')
%     
%    Example 02:
%     
%    s = [1 1 1 2 2 3];
%    t = [2 3 4 5 6 7];
%    names = {'A','B','C','D','E','F','G'};
%    [searchNodes,iterations] = dfs(s,t,names,'A')
%     
%    Example 03:
%     
%    s = [1 1 1 2 2 3];
%    t = [2 3 4 5 6 7];
%    [searchNodes,iterations] = dfs(s,t,1)
%     
%    Coded by Ali Asghar Manjotho
%    Lecturer, CSE-MUET
%    Email: ali.manjotho.ali@gmail.com
    iterations = table;
    
    % Refactor source, target, names & startNode vectors to numbers
    
    % If names argument missing 
    if (nargin<4)
        
        % Third argument (i.e. names) is starting Node
        startingNode = names;
        
        [s,t,n,sNode] = refactor(source,target,startingNode);
        
    else
        
        % Fourth argument (i.e. startNode) is starting Node
        startingNode = startNode;
        
        [s,t,n,sNode] = refactor(source,target,names,startingNode);        
        
    end
    
    % Get all unique nodes from source and target vectors
    uniqueNodes = getNodes(s,t);
     
    % Initialize visited list and queue
    visited = [];
    stack = [];
     
    % Set starting node as current node and add it in to stack and visited list
    currentNode = sNode;
    stack = [sNode stack];
    visited = [visited sNode];
          
    % Local variables to track iteration number
    iteration = 1;   
    
    % Update Iterations table
    iterations = [iterations; updateTable(s,t,n,currentNode,stack,visited,iteration,'Starting Node')];
    
    
    % Repeat until stack is empty
    while(~isempty(currentNode))
        
        % Get all childs of current node
        childs = getChilds(s,t,currentNode);
        
        
        newChildFound = 0;
            
        for i=1:length(childs)
               
            % If new unvisited child found add it in stack and visited list
            if(length(find(visited==childs(i)))==0)
                stack = [childs(i) stack];
                visited = [visited childs(i)];
                currentNode = childs(i);
                
                % Increase iteration number
                iteration = iteration + 1;
                iterations = [iterations; updateTable(s,t,n,currentNode,stack,visited,iteration,strcat('Unvisited node found?',n(currentNode)))];
                
                newChildFound = 1;
                
                break;
            end
        end
        
        % If no new child found for current node then remove last item
        % from stack and make it as current node
        if (newChildFound == 0)            
            comment = '';
            popedItem = [];
            
            if(length(stack)>0)
                popedItem = stack(1);
                stack(1) = [];
            end
            
            if(length(stack)>0)
                currentNode = stack(1);
                comment = strcat('Pop node from stack?',n(popedItem));
            else
                currentNode = [];
                comment = 'DFS Converged';
            end 
            
            iteration = iteration + 1;
            iterations = [iterations; updateTable(s,t,n,currentNode,stack,visited,iteration,comment)];
           
            
        end
            
            
    end
    
        
    searchNodes = n(visited);
    iterations.Properties.VariableNames = {'Iteration' 'CurrentNode' 'Stack' 'Visited' 'Comments'};
    
        
end
function childs = getChilds(source,target,node)
    
    childs = sort(target(find(source==node)));
    
end
function nodes = getNodes(s,t)
    nodes = unique(horzcat(s,t));
end
function [s,t,n,sn] = refactor(source,target,names,startNode)
    % If names argument missing 
    if (nargin<4)
        
        % Third argument (i.e. names) is starting Node
        sn = names;
    else
        
        % Fourth argument (i.e. startNode) is starting Node
        sn = startNode;  
        
    end
    
    % Get all unique nodes
    uNodes = unique(horzcat(source,target));
        
        
    
    % If source and target are cell arrays
    if(iscell(source) && iscell(target))
    
        % If names argument missing
        if(nargin<4)
            n = uNodes;
        else
            n = names;
        end
        
        
        % Get unique nodes cell array
        uNodes = unique(horzcat(source,target));
        s = [];
        t = [];
        % Populate source and target with equivalent numeric values
        for i=1:length(source)
            [sFound,sIndex] = ismember(source(i),uNodes);
            [tFound,tIndex] = ismember(target(i),uNodes);
            s = [s sIndex];
            t = [t tIndex];
        end
            
        
        
        
    else
        
        s = source;
        t = target;
        
        % If names argument missing
        if(nargin<4)    
            
            uNodes = unique(horzcat(source,target));
            n = cell(1,length(uNodes));
            
            
            for i=1:length(uNodes)
                n{i} = num2str(uNodes(i));
            end
            
        else
            n = names;
        end
    end
    
    
    
    % If starting node is not a number
    if(~isnumeric(sn))
        sn = find(ismember(n,sn));
        
    end
end
function tableIteration = updateTable(s,t,n,currentNode,stack,visited,iteration,comments)
   
    uniqueNodes = getNodes(s,t);
    % Display current queue
    stackStr = '[';
    
    for i=length(stack):-1:1
        if(i==1)
            stackStr = strcat(stackStr,sprintf('%s',char(n(find(uniqueNodes==stack(i))))));
        else
            stackStr = strcat(stackStr,sprintf('%s?',char(n(find(uniqueNodes==stack(i))))));
        end
    end
    stackStr = strcat(stackStr,sprintf(']'));
    
    
    % Display current visited list     
    visitedStr = '[';
    
    for i=1:length(visited)
        if(i==length(visited))
            visitedStr = strcat(visitedStr,sprintf('%s',char(n(find(uniqueNodes==visited(i))))));
        else
            visitedStr = strcat(visitedStr,sprintf('%s?',char(n(find(uniqueNodes==visited(i))))));
        end
    end
    
    visitedStr = strcat(visitedStr,sprintf(']'));
    % Display current node
    if(~isempty(currentNode))
        node = n(currentNode);        
        currentNodeStr = sprintf('[%s]',node{1,1}(1,1));
    else
        currentNodeStr = sprintf('[]');
    end
    array = {iteration currentNodeStr stackStr visitedStr comments};
    tableIteration = cell2table(array);
end