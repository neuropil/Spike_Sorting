% By chongxi lai
% 

function sim = similarity(vector1, vector2)

B =  max(norm(vector1),norm(vector2));
% B = norm(vector2);
EuDist = norm(vector1-vector2);
    if EuDist < B
        sim = 1-EuDist/B;
    else
        sim = 0;
    end
% cos_sim = abs(dot(vector1,vector2)/(norm(vector1)*norm(vector2)));
% sim = sim*cos_sim;

end