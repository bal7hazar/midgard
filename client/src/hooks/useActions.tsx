import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useDojo } from "@/dojo/useDojo";
import { usePlayer } from "./usePlayer";
import { useGame } from "./useGame";
import cartridgeConnector from '@/data/connectors' ;
import PlayerManager from "@/phaser/managers/player";
import GameManager from "@/phaser/managers/game";


export const useActions = () => {
  const {
    account: { account },
    setup: {
      systemCalls: { signup, start, hire, select, send, buy },
    },
  } = useDojo();

  const { player } = usePlayer({ playerId: account.address });
  const { game } = useGame({ gameId: player?.gameId });

  const handleSignup = useCallback(async (name: string) => {
    await signup({ account, name });
  }, [account]);

  const handleStart = useCallback(async () => {
    await start({ account });
  }, [account]);

  const handleHire = useCallback(async (builderId: number) => {
    await hire({ account, builderId });
  }, [account]);

  const handleSelect = useCallback(async (buildingId: number) => {
    await select({ account, buildingId });
  }, [account]);

  const handleSend = useCallback(async (builderId: number, buildingId: number) => {
    await send({ account, builderId, buildingId });
  }, [account]);

  const handleBuy = useCallback(async (quantity: number) => {
    await buy({ account, quantity });
  }, [account]);

  const playerManager = useMemo(() => {
    return PlayerManager.getInstance();
  }, []);

  const gameManager = useMemo(() => {
    return GameManager.getInstance();
  }, []);

  useEffect(() => {
    playerManager.setSignup(handleSignup); 
    playerManager.setPlayer(player);
  }, [playerManager, player, handleSignup]);

  useEffect(() => {
    const update = async () => {
      try {
        const username = await cartridgeConnector.username();
        if (!username) return;
        playerManager.setUsername(username);
      } catch (error) {
        return;
      }
    };
    update();
  }, [playerManager]);

  useEffect(() => {
    gameManager.setStart(handleStart);
    gameManager.setHire(handleHire);
    gameManager.setSelect(handleSelect);
    gameManager.setSend(handleSend);
    gameManager.setBuy(handleBuy);
    gameManager.setGame(game);
  }, [gameManager, game, handleStart, handleHire, handleSelect, handleSend, handleBuy]);
};
