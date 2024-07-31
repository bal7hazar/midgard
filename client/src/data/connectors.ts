import { Connector } from "@starknet-react/core";
import CartridgeConnector from "@cartridge/connector";
import { getContractByName } from "@dojoengine/core";
import manifest from "../../../contracts/manifests/dev/manifest.json";

const actions_contract_address = getContractByName(
  manifest,
  "midgard::systems::actions::actions",
)?.address;

const cartridgeConnector = new CartridgeConnector([], { theme: "midgard" });

export default cartridgeConnector;
