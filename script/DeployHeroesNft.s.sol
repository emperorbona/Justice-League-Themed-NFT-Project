// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Script} from "forge-std/Script.sol";
import {HeroesNft} from "src/HeroesNft.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract DeployHeroesNft is Script{
    HeroesNft heroesNft;

    function run() external returns(HeroesNft){
        string memory supermanSvg = vm.readFile("images/Superman.svg");
        string memory batmanSvg = vm.readFile("images/Batman.svg");
        string memory flashSvg = vm.readFile("images/Flash.svg");

        vm.startBroadcast();
        heroesNft = new HeroesNft(
            svgToImageURI(supermanSvg),
            svgToImageURI(batmanSvg),
            svgToImageURI(flashSvg)
        );
        vm.stopBroadcast();
        return heroesNft;
    }

    function svgToImageURI(string memory svg) public pure returns(string memory){
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(
            bytes(string(abi.encodePacked(svg)))
        );
        return string(abi.encodePacked(baseURL,svgBase64Encoded));
    }
}