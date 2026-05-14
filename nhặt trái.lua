--[[
 .____                  ________ ___.    _____                           __                
 |    |    __ _______   \_____  \\_ |___/ ____\_ __  ______ ____ _____ _/  |_  ___________ 
 |    |   |  |  \__  \   /   |   \| __ \   __\  |  \/  ___// ___\\__  \\   __\/  _ \_  __ \
 |    |___|  |  // __ \_/    |    \ \_\ \  | |  |  /\___ \\  \___ / __ \|  | (  <_> )  | \/
 |_______ \____/(____  /\_______  /___  /__| |____//____  >\___  >____  /__|  \____/|__|   
         \/          \/         \/    \/                \/     \/     \/                   
          \_Welcome to LuaObfuscator.com   (Alpha 0.10.9) ~  Much Love, Ferib 

]]--

local v0 = string.char;
local v1 = string.byte;
local v2 = string.sub;
local v3 = bit32 or bit;
local v4 = v3.bxor;
local v5 = table.concat;
local v6 = table.insert;
local function v7(v24, v25)
	local v26 = {};
	for v41 = 1, #v24 do
		v6(v26, v0(v4(v1(v2(v24, v41, v41 + 1)), v1(v2(v25, 1 + (v41 % #v25), 1 + (v41 % #v25) + 1))) % 256));
	end
	return v5(v26);
end
local v8 = tonumber;
local v9 = string.byte;
local v10 = string.char;
local v11 = string.sub;
local v12 = string.gsub;
local v13 = string.rep;
local v14 = table.concat;
local v15 = table.insert;
local v16 = math.ldexp;
local v17 = getfenv or function()
	return _ENV;
end;
local v18 = setmetatable;
local v19 = pcall;
local v20 = select;
local v21 = unpack or table.unpack;
local v22 = tonumber;
local function v23(v27, v28, ...)
	local v29 = 1;
	local v30;
	v27 = v12(v11(v27, 5), v7("\127\230", "\119\81\200\145"), function(v42)
		if (v9(v42, 2) == 81) then
			local v101 = 0;
			while true do
				if (0 == v101) then
					v30 = v8(v11(v42, 1, 1));
					return "";
				end
			end
		else
			local v102 = 0;
			local v103;
			while true do
				if (v102 == 0) then
					v103 = v10(v8(v42, 16));
					if v30 then
						local v122 = v13(v103, v30);
						v30 = nil;
						return v122;
					else
						return v103;
					end
					break;
				end
			end
		end
	end);
	local function v31(v43, v44, v45)
		if v45 then
			local v104 = 0;
			local v105;
			while true do
				if (v104 == 0) then
					v105 = (v43 / (2 ^ (v44 - (2 - 1)))) % ((5 - 3) ^ (((v45 - 1) - (v44 - (1 - 0))) + 1));
					return v105 - (v105 % 1);
				end
			end
		else
			local v106 = 0;
			local v107;
			while true do
				if (v106 == 0) then
					v107 = (4 - 2) ^ (v44 - 1);
					return (((v43 % (v107 + v107)) >= v107) and 1) or 0;
				end
			end
		end
	end
	local function v32()
		local v46 = v9(v27, v29, v29);
		v29 = v29 + 1;
		return v46;
	end
	local function v33()
		local v47 = 0;
		local v48;
		local v49;
		while true do
			if (0 == v47) then
				v48, v49 = v9(v27, v29, v29 + 2);
				v29 = v29 + 2;
				v47 = 1;
			end
			if (v47 == 1) then
				return (v49 * (875 - (555 + 64))) + v48;
			end
		end
	end
	local function v34()
		local v50 = 0;
		local v51;
		local v52;
		local v53;
		local v54;
		while true do
			if (v50 == 0) then
				v51, v52, v53, v54 = v9(v27, v29, v29 + (934 - (857 + 74)));
				v29 = v29 + (572 - (367 + 201));
				v50 = 1;
			end
			if (1 == v50) then
				return (v54 * 16777216) + (v53 * 65536) + (v52 * 256) + v51;
			end
		end
	end
	local function v35()
		local v55 = v34();
		local v56 = v34();
		local v57 = 1;
		local v58 = (v31(v56, 928 - (214 + 713), 20) * (2 ^ 32)) + v55;
		local v59 = v31(v56, 21, 31);
		local v60 = ((v31(v56, 32) == 1) and -1) or 1;
		if (v59 == 0) then
			if (v58 == 0) then
				return v60 * (0 + 0);
			else
				v59 = 1;
				v57 = 0 + 0;
			end
		elseif (v59 == 2047) then
			return ((v58 == 0) and (v60 * (1 / (877 - (282 + 595))))) or (v60 * NaN);
		end
		return v16(v60, v59 - 1023) * (v57 + (v58 / (2 ^ 52)));
	end
	local function v36(v61)
		local v62 = 0;
		local v63;
		local v64;
		while true do
			if (v62 == 3) then
				return v14(v64);
			end
			if (1 == v62) then
				v63 = v11(v27, v29, (v29 + v61) - 1);
				v29 = v29 + v61;
				v62 = 2;
			end
			if (v62 == 0) then
				v63 = nil;
				if not v61 then
					local v117 = 0;
					while true do
						if (0 == v117) then
							v61 = v34();
							if (v61 == 0) then
								return "";
							end
							break;
						end
					end
				end
				v62 = 1;
			end
			if (v62 == 2) then
				v64 = {};
				for v111 = 1, #v63 do
					v64[v111] = v10(v9(v11(v63, v111, v111)));
				end
				v62 = 3;
			end
		end
	end
	local v37 = v34;
	local function v38(...)
		return {...}, v20("#", ...);
	end
	local function v39()
		local v65 = {};
		local v66 = {};
		local v67 = {};
		local v68 = {v65,v66,nil,v67};
		local v69 = v34();
		local v70 = {};
		for v78 = 1, v69 do
			local v79 = v32();
			local v80;
			if (v79 == 1) then
				v80 = v32() ~= 0;
			elseif (v79 == 2) then
				v80 = v35();
			elseif (v79 == 3) then
				v80 = v36();
			end
			v70[v78] = v80;
		end
		v68[3] = v32();
		for v82 = 1, v34() do
			local v83 = 0;
			local v84;
			while true do
				if (v83 == 0) then
					v84 = v32();
					if (v31(v84, 1, 1) == 0) then
						local v118 = v31(v84, 2, 3);
						local v119 = v31(v84, 4 + 0, 6);
						local v120 = {v33(),v33(),nil,nil};
						if (v118 == 0) then
							local v123 = 0;
							while true do
								if (v123 == 0) then
									v120[3] = v33();
									v120[4] = v33();
									break;
								end
							end
						elseif (v118 == (1066 - (68 + 997))) then
							v120[3] = v34();
						elseif (v118 == 2) then
							v120[3] = v34() - (2 ^ 16);
						elseif (v118 == 3) then
							v120[3] = v34() - (2 ^ 16);
							v120[4] = v33();
						end
						if (v31(v119, 1, 1) == 1) then
							v120[2] = v70[v120[1272 - (226 + 1044)]];
						end
						if (v31(v119, 2, 2) == (4 - 3)) then
							v120[120 - (32 + 85)] = v70[v120[3]];
						end
						if (v31(v119, 3, 3) == 1) then
							v120[4] = v70[v120[4]];
						end
						v65[v82] = v120;
					end
					break;
				end
			end
		end
		for v85 = 1, v34() do
			v66[v85 - 1] = v39();
		end
		return v68;
	end
	local function v40(v72, v73, v74)
		local v75 = v72[1];
		local v76 = v72[2];
		local v77 = v72[3];
		return function(...)
			local v87 = v75;
			local v88 = v76;
			local v89 = v77;
			local v90 = v38;
			local v91 = 1;
			local v92 = -1;
			local v93 = {};
			local v94 = {...};
			local v95 = v20("#", ...) - 1;
			local v96 = {};
			local v97 = {};
			for v108 = 0, v95 do
				if (v108 >= v89) then
					v93[v108 - v89] = v94[v108 + 1];
				else
					v97[v108] = v94[v108 + 1];
				end
			end
			local v98 = (v95 - v89) + 1 + 0;
			local v99;
			local v100;
			while true do
				v99 = v87[v91];
				v100 = v99[1];
				if (v100 <= 18) then
					if (v100 <= 8) then
						if (v100 <= 3) then
							if (v100 <= 1) then
								if (v100 == 0) then
									do
										return v97[v99[2]]();
									end
								else
									local v134 = v99[959 - (892 + 65)];
									local v135 = v97[v134];
									for v191 = v134 + 1, v92 do
										v15(v135, v97[v191]);
									end
								end
							elseif (v100 == 2) then
								v97[v99[4 - 2]] = v97[v99[3]] + v99[4];
							else
								local v137 = v99[2];
								local v138, v139 = v90(v97[v137](v97[v137 + 1]));
								v92 = (v139 + v137) - 1;
								local v140 = 0;
								for v192 = v137, v92 do
									local v193 = 0;
									while true do
										if (0 == v193) then
											v140 = v140 + 1;
											v97[v192] = v138[v140];
											break;
										end
									end
								end
							end
						elseif (v100 <= (9 - 4)) then
							if (v100 > 4) then
								local v141 = 0;
								local v142;
								while true do
									if (v141 == 0) then
										v142 = v99[2];
										v97[v142](v21(v97, v142 + 1, v92));
										break;
									end
								end
							else
								do
									return;
								end
							end
						elseif (v100 <= 6) then
							local v143 = v99[2];
							local v144 = v97[v143 + 2];
							local v145 = v97[v143] + v144;
							v97[v143] = v145;
							if (v144 > (0 - 0)) then
								if (v145 <= v97[v143 + 1]) then
									local v306 = 0;
									while true do
										if (v306 == 0) then
											v91 = v99[3];
											v97[v143 + 3] = v145;
											break;
										end
									end
								end
							elseif (v145 >= v97[v143 + 1]) then
								local v307 = 0;
								while true do
									if (v307 == 0) then
										v91 = v99[353 - (87 + 263)];
										v97[v143 + 3] = v145;
										break;
									end
								end
							end
						elseif (v100 == 7) then
							v97[v99[2]] = v73[v99[3]];
						else
							local v200 = 0;
							local v201;
							local v202;
							local v203;
							local v204;
							local v205;
							while true do
								if (v200 == 4) then
									v97[v99[2]] = v99[7 - 4];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v99[3];
									v200 = 5;
								end
								if (v200 == 8) then
									v201 = 0;
									for v390 = v205, v92 do
										local v391 = 0;
										while true do
											if (v391 == 0) then
												v201 = v201 + 1;
												v97[v390] = v202[v201];
												break;
											end
										end
									end
									v91 = v91 + 1;
									v99 = v87[v91];
									v200 = 9;
								end
								if (v200 == 1) then
									v97[v99[2]] = v74[v99[183 - (67 + 113)]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v205 = v99[2];
									v200 = 2;
								end
								if (5 == v200) then
									v91 = v91 + 1 + 0;
									v99 = v87[v91];
									v205 = v99[2];
									v202, v203 = v90(v97[v205](v21(v97, v205 + (3 - 2), v99[3])));
									v200 = 6;
								end
								if (v200 == 2) then
									v204 = v97[v99[3]];
									v97[v205 + 1] = v204;
									v97[v205] = v204[v99[4]];
									v91 = v91 + 1;
									v200 = 3;
								end
								if (v200 == 9) then
									v205 = v99[2];
									v97[v205] = v97[v205](v21(v97, v205 + 1, v92));
									v91 = v91 + 1;
									v99 = v87[v91];
									v200 = 10;
								end
								if (v200 == 10) then
									v97[v99[2]]();
									v91 = v91 + 1;
									v99 = v87[v91];
									v91 = v99[3];
									break;
								end
								if (v200 == 6) then
									v92 = (v203 + v205) - 1;
									v201 = 0;
									for v392 = v205, v92 do
										v201 = v201 + 1;
										v97[v392] = v202[v201];
									end
									v91 = v91 + 1;
									v200 = 7;
								end
								if (v200 == 3) then
									v99 = v87[v91];
									v97[v99[2 + 0]] = v73[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v200 = 4;
								end
								if (v200 == 0) then
									v201 = nil;
									v202, v203 = nil;
									v204 = nil;
									v205 = nil;
									v200 = 1;
								end
								if (v200 == 7) then
									v99 = v87[v91];
									v205 = v99[954 - (802 + 150)];
									v202, v203 = v90(v97[v205](v21(v97, v205 + 1, v92)));
									v92 = (v203 + v205) - 1;
									v200 = 8;
								end
							end
						end
					elseif (v100 <= 13) then
						if (v100 <= 10) then
							if (v100 > (23 - 14)) then
								local v147 = 0;
								local v148;
								local v149;
								local v150;
								local v151;
								while true do
									if (v147 == 0) then
										v148 = v99[3 - 1];
										v149, v150 = v90(v97[v148](v21(v97, v148 + 1, v92)));
										v147 = 1;
									end
									if (2 == v147) then
										for v308 = v148, v92 do
											local v309 = 0;
											while true do
												if (v309 == 0) then
													v151 = v151 + 1;
													v97[v308] = v149[v151];
													break;
												end
											end
										end
										break;
									end
									if (v147 == 1) then
										v92 = (v150 + v148) - 1;
										v151 = 0 + 0;
										v147 = 2;
									end
								end
							else
								v97[v99[2]]();
							end
						elseif (v100 <= 11) then
							if (v97[v99[2]] == v99[4]) then
								v91 = v91 + 1;
							else
								v91 = v99[3];
							end
						elseif (v100 == 12) then
							local v207 = 0;
							while true do
								if (v207 == 0) then
									v97[v99[2]] = v74[v99[3]];
									v91 = v91 + (998 - (915 + 82));
									v99 = v87[v91];
									v207 = 1;
								end
								if (6 == v207) then
									v97[v99[1189 - (1069 + 118)]] = v74[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 7;
								end
								if (v207 == 5) then
									v97[v99[2]] = v97[v99[3]][v99[4]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 6;
								end
								if (2 == v207) then
									v97[v99[2]] = v74[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 3;
								end
								if (v207 == 4) then
									v97[v99[2 - 0]] = v74[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 5;
								end
								if (7 == v207) then
									if not v97[v99[2]] then
										v91 = v91 + 1;
									else
										v91 = v99[3];
									end
									break;
								end
								if (v207 == 1) then
									v97[v99[5 - 3]] = v97[v99[3]][v99[4]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 2;
								end
								if (3 == v207) then
									v97[v99[2]] = v97[v99[2 + 1]][v99[4]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v207 = 4;
								end
							end
						else
							local v208;
							local v209, v210;
							local v211;
							v97[v99[2]] = v99[3];
							v91 = v91 + 1;
							v99 = v87[v91];
							v211 = v99[2];
							v97[v211] = v97[v211](v21(v97, v211 + 1, v99[3]));
							v91 = v91 + 1;
							v99 = v87[v91];
							v97[v99[2]] = v99[3];
							v91 = v91 + 1;
							v99 = v87[v91];
							v211 = v99[2];
							v209, v210 = v90(v97[v211](v21(v97, v211 + 1, v99[3])));
							v92 = (v210 + v211) - 1;
							v208 = 0;
							for v243 = v211, v92 do
								v208 = v208 + 1;
								v97[v243] = v209[v208];
							end
							v91 = v91 + 1;
							v99 = v87[v91];
							v211 = v99[2];
							v97[v211] = v97[v211](v21(v97, v211 + (2 - 1), v92));
							v91 = v91 + 1;
							v99 = v87[v91];
							if (v97[v99[2]] == v99[4]) then
								v91 = v91 + 1;
							else
								v91 = v99[3];
							end
						end
					elseif (v100 <= 15) then
						if (v100 > (30 - 16)) then
							local v152 = 0;
							local v153;
							local v154;
							local v155;
							local v156;
							while true do
								if (v152 == 10) then
									v91 = v91 + 1;
									v99 = v87[v91];
									v156 = v99[2];
									v97[v156] = v97[v156](v21(v97, v156 + 1, v92));
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[1488 - (998 + 488)]] = v97[v99[3]] % v99[2 + 2];
									v91 = v91 + 1;
									v152 = 11;
								end
								if (v152 == 1) then
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[4 - 1]];
									v152 = 2;
								end
								if (v152 == 11) then
									v99 = v87[v91];
									v156 = v99[2 + 0];
									v154, v155 = v90(v97[v156](v97[v156 + 1]));
									v92 = (v155 + v156) - 1;
									v153 = 0;
									for v311 = v156, v92 do
										v153 = v153 + 1;
										v97[v311] = v154[v153];
									end
									v91 = v91 + 1;
									v99 = v87[v91];
									v152 = 12;
								end
								if (7 == v152) then
									v97[v99[2]] = #v97[v99[2 + 1]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v97[v99[3]] % v97[v99[6 - 2]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v99[3] + v97[v99[4]];
									v91 = v91 + 1;
									v152 = 8;
								end
								if (v152 == 6) then
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v97[v99[3]] % v97[v99[4]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[444 - (416 + 26)]] = v99[3] + v97[v99[12 - 8]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v152 = 7;
								end
								if (v152 == 2) then
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v97[v99[3]];
									v91 = v91 + 1 + 0;
									v99 = v87[v91];
									v97[v99[793 - (368 + 423)]] = v97[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v152 = 3;
								end
								if (v152 == 0) then
									v153 = nil;
									v154, v155 = nil;
									v156 = nil;
									v97[v99[2]] = v97[v99[3]];
									v91 = v91 + 1 + 0;
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[3]];
									v91 = v91 + 1;
									v152 = 1;
								end
								if (12 == v152) then
									v156 = v99[2];
									v97[v156](v21(v97, v156 + (773 - (201 + 571)), v92));
									break;
								end
								if (v152 == 9) then
									for v314 = v156, v92 do
										local v315 = 0;
										while true do
											if (v315 == 0) then
												v153 = v153 + 1;
												v97[v314] = v154[v153];
												break;
											end
										end
									end
									v91 = v91 + 1;
									v99 = v87[v91];
									v156 = v99[2];
									v154, v155 = v90(v97[v156](v21(v97, v156 + 1, v92)));
									v92 = (v155 + v156) - 1;
									v153 = 0;
									for v316 = v156, v92 do
										v153 = v153 + (431 - (44 + 386));
										v97[v316] = v154[v153];
									end
									v152 = 10;
								end
								if (v152 == 5) then
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[7 - 5]] = v97[v99[3]];
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = #v97[v99[3]];
									v152 = 6;
								end
								if (v152 == 8) then
									v99 = v87[v91];
									v97[v99[2]] = v97[v99[3]] + v99[4];
									v91 = v91 + 1;
									v99 = v87[v91];
									v156 = v99[2];
									v154, v155 = v90(v97[v156](v21(v97, v156 + 1, v99[3])));
									v92 = (v155 + v156) - (439 - (145 + 293));
									v153 = 0;
									v152 = 9;
								end
								if (v152 == 4) then
									v91 = v91 + 1;
									v99 = v87[v91];
									v156 = v99[2];
									v97[v156] = v97[v156](v21(v97, v156 + 1, v92));
									v91 = v91 + 1;
									v99 = v87[v91];
									v97[v99[2]] = v73[v99[3]];
									v91 = v91 + (19 - (10 + 8));
									v152 = 5;
								end
								if (v152 == 3) then
									v97[v99[2]] = v97[v99[3]] + v99[4];
									v91 = v91 + 1;
									v99 = v87[v91];
									v156 = v99[6 - 4];
									v154, v155 = v90(v97[v156](v21(v97, v156 + 1, v99[3])));
									v92 = (v155 + v156) - 1;
									v153 = 0;
									for v319 = v156, v92 do
										v153 = v153 + 1;
										v97[v319] = v154[v153];
									end
									v152 = 4;
								end
							end
						else
							v91 = v99[3];
						end
					elseif (v100 <= 16) then
						local v158 = 0;
						local v159;
						while true do
							if (v158 == 0) then
								v159 = v99[2];
								do
									return v97[v159](v21(v97, v159 + 1, v99[3]));
								end
								break;
							end
						end
					elseif (v100 == 17) then
						v97[v99[2]] = v97[v99[3]] % v99[4];
					else
						v97[v99[2]] = v74[v99[3]];
					end
				elseif (v100 <= 27) then
					if (v100 <= 22) then
						if (v100 <= 20) then
							if (v100 == 19) then
								local v160 = v99[2];
								local v161 = v97[v160];
								local v162 = v97[v160 + 2];
								if (v162 > 0) then
									if (v161 > v97[v160 + (1139 - (116 + 1022))]) then
										v91 = v99[3];
									else
										v97[v160 + 3] = v161;
									end
								elseif (v161 < v97[v160 + (4 - 3)]) then
									v91 = v99[3];
								else
									v97[v160 + 3] = v161;
								end
							else
								local v163 = v99[2];
								v97[v163] = v97[v163](v21(v97, v163 + 1, v92));
							end
						elseif (v100 == 21) then
							v97[v99[2]] = v97[v99[3]];
						else
							local v167;
							local v168;
							local v169;
							v97[v99[2]] = {};
							v91 = v91 + 1;
							v99 = v87[v91];
							v97[v99[2]] = v99[3];
							v91 = v91 + 1;
							v99 = v87[v91];
							v97[v99[2]] = #v97[v99[3]];
							v91 = v91 + 1;
							v99 = v87[v91];
							v97[v99[2]] = v99[3];
							v91 = v91 + 1;
							v99 = v87[v91];
							v169 = v99[2];
							v168 = v97[v169];
							v167 = v97[v169 + 2 + 0];
							if (v167 > 0) then
								if (v168 > v97[v169 + 1]) then
									v91 = v99[3];
								else
									v97[v169 + 3] = v168;
								end
							elseif (v168 < v97[v169 + 1]) then
								v91 = v99[3];
							else
								v97[v169 + (10 - 7)] = v168;
							end
						end
					elseif (v100 <= 24) then
						if (v100 > 23) then
							v97[v99[2]] = v97[v99[3]] % v97[v99[4]];
						else
							v97[v99[2]] = v97[v99[3]][v99[4]];
						end
					elseif (v100 <= 25) then
						local v179 = 0;
						local v180;
						local v181;
						local v182;
						while true do
							if (v179 == 1) then
								v182 = {};
								v181 = v18({}, {[v7("\243\9\34\130\52\169\177", "\37\172\86\75\236\80\204\201")]=function(v330, v331)
									local v332 = v182[v331];
									return v332[1][v332[2]];
								end,[v7("\180\77\79\114\146\247\125\235\142\106", "\143\235\18\33\23\229\158\19")]=function(v333, v334, v335)
									local v336 = 0;
									local v337;
									while true do
										if (v336 == 0) then
											v337 = v182[v334];
											v337[1][v337[2]] = v335;
											break;
										end
									end
								end});
								v179 = 2;
							end
							if (v179 == 0) then
								v180 = v88[v99[3]];
								v181 = nil;
								v179 = 1;
							end
							if (v179 == 2) then
								for v338 = 1, v99[4] do
									v91 = v91 + 1;
									local v339 = v87[v91];
									if (v339[1] == 21) then
										v182[v338 - 1] = {v97,v339[3]};
									else
										v182[v338 - 1] = {v73,v339[3]};
									end
									v96[#v96 + 1] = v182;
								end
								v97[v99[861 - (814 + 45)]] = v40(v180, v181, v74);
								break;
							end
						end
					elseif (v100 > 26) then
						v97[v99[2]] = v99[3] + v97[v99[4]];
					else
						v97[v99[2]] = {};
					end
				elseif (v100 <= 32) then
					if (v100 <= 29) then
						if (v100 == 28) then
							for v194 = v99[2], v99[3] do
								v97[v194] = nil;
							end
						elseif not v97[v99[2]] then
							v91 = v91 + (2 - 1);
						else
							v91 = v99[3];
						end
					elseif (v100 <= 30) then
						v97[v99[2]] = v99[3];
					elseif (v100 > 31) then
						local v223 = 0;
						local v224;
						while true do
							if (v223 == 0) then
								v224 = v99[2];
								v97[v224] = v97[v224](v21(v97, v224 + 1, v99[1 + 2]));
								break;
							end
						end
					else
						local v225 = v99[2];
						local v226, v227 = v90(v97[v225](v21(v97, v225 + 1, v99[2 + 1])));
						v92 = (v227 + v225) - 1;
						local v228 = 0;
						for v291 = v225, v92 do
							local v292 = 0;
							while true do
								if (0 == v292) then
									v228 = v228 + (886 - (261 + 624));
									v97[v291] = v226[v228];
									break;
								end
							end
						end
					end
				elseif (v100 <= 34) then
					if (v100 == 33) then
						local v185 = 0;
						local v186;
						while true do
							if (v185 == 0) then
								v186 = v99[2];
								do
									return v21(v97, v186, v92);
								end
								break;
							end
						end
					else
						v97[v99[2]] = #v97[v99[4 - 1]];
					end
				elseif (v100 <= 35) then
					local v188 = 0;
					local v189;
					local v190;
					while true do
						if (v188 == 1) then
							v97[v189 + 1] = v190;
							v97[v189] = v190[v99[4]];
							break;
						end
						if (v188 == 0) then
							v189 = v99[2];
							v190 = v97[v99[3]];
							v188 = 1;
						end
					end
				elseif (v100 == 36) then
					if v97[v99[2]] then
						v91 = v91 + 1;
					else
						v91 = v99[3];
					end
				else
					local v229;
					local v230;
					local v231, v232;
					local v233;
					v97[v99[2]] = v73[v99[3]];
					v91 = v91 + (1081 - (1020 + 60));
					v99 = v87[v91];
					v97[v99[2]] = v73[v99[3]];
					v91 = v91 + 1;
					v99 = v87[v91];
					v97[v99[2]] = v73[v99[1426 - (630 + 793)]];
					v91 = v91 + 1;
					v99 = v87[v91];
					v97[v99[2]] = {};
					v91 = v91 + (3 - 2);
					v99 = v87[v91];
					v97[v99[2]] = v73[v99[3]];
					v91 = v91 + 1;
					v99 = v87[v91];
					v97[v99[2]] = v97[v99[3]];
					v91 = v91 + 1;
					v99 = v87[v91];
					for v299 = v99[2], v99[3] do
						v97[v299] = nil;
					end
					v91 = v91 + 1;
					v99 = v87[v91];
					v233 = v99[2];
					v231, v232 = v90(v97[v233](v21(v97, v233 + (4 - 3), v99[3])));
					v92 = (v232 + v233) - 1;
					v230 = 0;
					for v301 = v233, v92 do
						local v302 = 0;
						while true do
							if (0 == v302) then
								v230 = v230 + 1;
								v97[v301] = v231[v230];
								break;
							end
						end
					end
					v91 = v91 + 1;
					v99 = v87[v91];
					v233 = v99[2];
					v229 = v97[v233];
					for v303 = v233 + 1, v92 do
						v15(v229, v97[v303]);
					end
				end
				v91 = v91 + 1;
			end
		end;
	end
	return v40(v39(), {}, v28)(...);
end
return v23("LOL!0D3Q0003063Q00737472696E6703043Q006368617203043Q00627974652Q033Q0073756203053Q0062697433322Q033Q0062697403043Q0062786F7203053Q007461626C6503063Q00636F6E63617403063Q00696E7365727403053Q006D6174636803083Q00746F6E756D62657203053Q007063612Q6C00243Q00120C3Q00013Q00206Q000200122Q000100013Q00202Q00010001000300122Q000200013Q00202Q00020002000400122Q000300053Q00062Q0003000A0001000100040E3Q000A0001002Q12000300063Q002017000400030007002Q12000500083Q002017000500050009002Q12000600083Q00201700060006000A00061900073Q000100062Q00153Q00064Q00158Q00153Q00044Q00153Q00014Q00153Q00024Q00153Q00053Q002Q12000800013Q00201700080008000B002Q120009000C3Q002Q12000A000D3Q000619000B0001000100052Q00153Q00074Q00153Q00094Q00153Q00084Q00153Q000A4Q00153Q000B4Q0015000C000B6Q000C00014Q0021000C6Q00043Q00013Q00023Q00023Q00026Q00F03F026Q00704002264Q001600025Q00122Q000300016Q00045Q00122Q000500013Q00042Q0003002100012Q000700076Q000F000800026Q000900016Q000A00026Q000B00036Q000C00046Q000D8Q000E00063Q00202Q000F000600014Q000C000F6Q000B3Q00024Q000C00036Q000D00046Q000E00016Q000F00016Q000F0006000F00102Q000F0001000F4Q001000016Q00100006001000102Q00100001001000202Q0010001000014Q000D00106Q000C8Q000A3Q000200202Q000A000A00024Q0009000A6Q00073Q00010004060003000500012Q0007000300054Q0015000400024Q0010000300044Q002100036Q00043Q00017Q00043Q00027Q004003053Q003A25642B3A2Q033Q0025642B026Q00F03F001C3Q0006195Q000100012Q00078Q0025000100016Q000200026Q000300026Q00048Q000500036Q00068Q000700076Q000500076Q00043Q000100201700040004000100120D000500026Q00030005000200122Q000400036Q000200046Q00013Q000200262Q000100180001000400040E3Q001800012Q001500016Q001A00026Q0010000100024Q002100015Q00040E3Q001B00012Q0007000100046Q000100014Q002100016Q00043Q00013Q00013Q00063Q00030A3Q006C6F6164737472696E6703043Q0067616D6503073Q00482Q747047657403203Q00D9D7CF35F5E18851C1C2C831E3BDDE50D0D3CB6AEFB4EA4CC8CDCB2C2QA9C60903083Q007EB1A3BB4586DBA7026Q00F03F010F3Q0006243Q000D00013Q00040E3Q000D0001002Q12000100013Q001208000200023Q00202Q0002000200034Q00045Q00122Q000500043Q00122Q000600056Q000400066Q00028Q00013Q00024Q00010001000100044Q000E000100201700013Q00062Q00043Q00017Q00", v17(), ...);