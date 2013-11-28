function [ be ] = bandsEnergy( mat )
    be = [
        energy(mat(:, 1:8)), ...
        energy(mat(:, 9:16)), ...
        energy(mat(:, 17:24)), ...
        energy(mat(:, 25:32)), ...
        energy(mat(:, 33:40)), ...
        energy(mat(:, 41:48)), ...
        energy(mat(:, 49:56)), ...
        energy(mat(:, 57:64)), ...
        energy(mat(:, 1:16)), ...
        energy(mat(:, 17:32)), ...
        energy(mat(:, 33:48)), ...
        energy(mat(:, 49:64)), ...
        energy(mat(:, 1:24)), ...
        energy(mat(:, 25:48))
    ];
end
