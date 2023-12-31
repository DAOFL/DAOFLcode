// Sources flattened with hardhat v2.12.6 https://hardhat.org

// File @openzeppelin/contracts/utils/Address.sol@v4.8.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResultFromTarget(target, success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verify that a low level call to smart-contract was successful, and revert (either by bubbling
     * the revert reason or using the provided one) in case of unsuccessful call or if target was not a contract.
     *
     * _Available since v4.8._
     */
    function verifyCallResultFromTarget(
        address target,
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        if (success) {
            if (returndata.length == 0) {
                // only check isContract if the call was successful and the return data is empty
                // otherwise we already know that it was a contract
                require(isContract(target), "Address: call to non-contract");
            }
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    /**
     * @dev Tool to verify that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason or using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            _revert(returndata, errorMessage);
        }
    }

    function _revert(bytes memory returndata, string memory errorMessage) private pure {
        // Look for revert reason and bubble it up if present
        if (returndata.length > 0) {
            // The easiest way to bubble the revert reason is using memory via assembly
            /// @solidity memory-safe-assembly
            assembly {
                let returndata_size := mload(returndata)
                revert(add(32, returndata), returndata_size)
            }
        } else {
            revert(errorMessage);
        }
    }
}


// File @openzeppelin/contracts/utils/Context.sol@v4.8.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}


// File @openzeppelin/contracts/utils/Counters.sol@v4.8.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (utils/Counters.sol)

pragma solidity ^0.8.0;

/**
 * @title Counters
 * @author Matt Condon (@shrugs)
 * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
 * of elements in a mapping, issuing ERC721 ids, or counting request ids.
 *
 * Include with `using Counters for Counters.Counter;`
 */
library Counters {
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        uint256 _value; // default: 0
    }

    function current(Counter storage counter) internal view returns (uint256) {
        return counter._value;
    }

    function increment(Counter storage counter) internal {
        unchecked {
            counter._value += 1;
        }
    }

    function decrement(Counter storage counter) internal {
        uint256 value = counter._value;
        require(value > 0, "Counter: decrement overflow");
        unchecked {
            counter._value = value - 1;
        }
    }

    function reset(Counter storage counter) internal {
        counter._value = 0;
    }
}


// File @openzeppelin/contracts/utils/structs/EnumerableSet.sol@v4.8.3

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.8.0) (utils/structs/EnumerableSet.sol)
// This file was procedurally generated from scripts/generate/templates/EnumerableSet.js.

pragma solidity ^0.8.0;

/**
 * @dev Library for managing
 * https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
 * types.
 *
 * Sets have the following properties:
 *
 * - Elements are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Elements are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableSet for EnumerableSet.AddressSet;
 *
 *     // Declare a set state variable
 *     EnumerableSet.AddressSet private mySet;
 * }
 * ```
 *
 * As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)
 * and `uint256` (`UintSet`) are supported.
 *
 * [WARNING]
 * ====
 * Trying to delete such a structure from storage will likely result in data corruption, rendering the structure
 * unusable.
 * See https://github.com/ethereum/solidity/pull/11843[ethereum/solidity#11843] for more info.
 *
 * In order to clean an EnumerableSet, you can either remove all elements one by one or create a fresh instance using an
 * array of EnumerableSet.
 * ====
 */
library EnumerableSet {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Set type with
    // bytes32 values.
    // The Set implementation uses private functions, and user-facing
    // implementations (such as AddressSet) are just wrappers around the
    // underlying Set.
    // This means that we can only create new EnumerableSets for types that fit
    // in bytes32.

    struct Set {
        // Storage of set values
        bytes32[] _values;
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping(bytes32 => uint256) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];

        if (valueIndex != 0) {
            // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            if (lastIndex != toDeleteIndex) {
                bytes32 lastValue = set._values[lastIndex];

                // Move the last value to the index where the value to delete is
                set._values[toDeleteIndex] = lastValue;
                // Update the index for the moved value
                set._indexes[lastValue] = valueIndex; // Replace lastValue's index to valueIndex
            }

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(Set storage set, bytes32 value) private view returns (bool) {
        return set._indexes[value] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(Set storage set, uint256 index) private view returns (bytes32) {
        return set._values[index];
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function _values(Set storage set) private view returns (bytes32[] memory) {
        return set._values;
    }

    // Bytes32Set

    struct Bytes32Set {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(Bytes32Set storage set, bytes32 value) internal view returns (bool) {
        return _contains(set._inner, value);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(Bytes32Set storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(Bytes32Set storage set, uint256 index) internal view returns (bytes32) {
        return _at(set._inner, index);
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(Bytes32Set storage set) internal view returns (bytes32[] memory) {
        bytes32[] memory store = _values(set._inner);
        bytes32[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }

    // AddressSet

    struct AddressSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(AddressSet storage set, address value) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(AddressSet storage set) internal view returns (address[] memory) {
        bytes32[] memory store = _values(set._inner);
        address[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }

    // UintSet

    struct UintSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(UintSet storage set) internal view returns (uint256[] memory) {
        bytes32[] memory store = _values(set._inner);
        uint256[] memory result;

        /// @solidity memory-safe-assembly
        assembly {
            result := store
        }

        return result;
    }
}


// File contracts/IDAOMTC.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


interface IDAOMTC {
   
   function mint(address recipient) external returns(bool);
   function burn(address recipient) external returns(bool);
   function totalSupply() external view returns (uint256);
   function balanceOf(address account) external view returns (uint256);
}


// File contracts/util/EnumerableSetExtra.sol

/**
 * SPDX-License-Identifier: MIT
 *
 * Copyright (c) 2020 Coinbase, Inc.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

pragma solidity ^0.8.7;
/**
 * @notice Extra functions for enumerable sets
 */
library EnumerableSetExtra {
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.UintSet;

    /**
     * @notice Remove all elements from the address set
     */
    function clear(EnumerableSet.AddressSet storage set) internal {
        bytes32[] storage values = set._inner._values;
        mapping(bytes32 => uint256) storage indexes = set._inner._indexes;
        uint256 count = values.length;
        for (uint256 i = 0; i < count; i++) {
            delete indexes[values[i]];
        }
        delete set._inner._values;
    }

    /**
     * @notice Return all elements in the address set as an array
     */
    function elements(EnumerableSet.AddressSet storage set)
        internal
        view
        returns (address[] memory)
    {
        uint256 count = set.length();
        address[] memory list = new address[](count);
        for (uint256 i = 0; i < count; i++) {
            list[i] = set.at(i);
        }
        return list;
    }

    /**
     * @notice Return all elements in the uint set as an array
     */
    function elements(EnumerableSet.UintSet storage set)
        internal
        view
        returns (uint256[] memory)
    {
        uint256 count = set.length();
        uint256[] memory list = new uint256[](count);
        for (uint256 i = 0; i < count; i++) {
            list[i] = set.at(i);
        }
        return list;
    }
}


// File contracts/MultiSigC.sol

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() virtual{
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     */

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
contract MultiSigC is Ownable{
    
    using Counters for Counters.Counter;
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.UintSet;
    using EnumerableSetExtra for EnumerableSet.AddressSet;
    using EnumerableSetExtra for EnumerableSet.UintSet;

    address payable public DAOFLCAddr;
    address payable public ODAOMTCAddr;

    bool public createFLNFTf=false;

    Counters.Counter private _ProposalId;

    enum ProposalState {
        NotExist, // Default state (0) for nonexistent proposals
        Open, // Proposal can receive approvals
        Executable, // Proposal has received required number of approvals
        Closed, // Proposal is closed
        Executed // Proposal has been executed
    }

    struct Proposal {
        ProposalState state;
        bytes4 selector;
        bytes argumentData;
        // Addresses of accounts that have submitted approvals
        EnumerableSet.AddressSet approvals;
    }

    struct ContractCallType {
        
        Configuration config;
        // IDs of open proposals for this type of contract call
        EnumerableSet.UintSet openProposals;

        uint256 numOpenProposals;
        
    }


    struct Configuration {
        string configName;
        // Maximum number of open proposals per approver - if exceeded, the
        // approvers has to close or execute an existing open proposal to be able
        // to create another proposal.
        uint256 maxOpenProposals;
    }

    /**
     * @dev Preconfigured contract call types:
     * Function selector => ContractCallType
     */
    mapping(bytes4 => ContractCallType) private _types;
    bytes4[] private _typeKeys;

    /**
     * @dev Proposals: Proposal ID => Proposal
     */
    mapping(uint256 => Proposal) private _proposals;

    uint public GI = 0;

    /**
     * @dev Proposals: Proposal ID => pGI
     */
    mapping(uint256 => uint256) private pGI;
    /**
     * @dev Proposals: Proposal ID => tokenURI
     */
    mapping(uint256 => string) private tokenURIs;
    /**
     * @dev Proposals: Proposal ID => GMCID
     */
    mapping(uint256 => string) private GMCIDs;

    /**
     * @dev GI => selector => bool
     */
    
    mapping(uint256 => mapping (bytes4 => bool)) public executionf;  //proposal id => aelector => executionf


    event createFLNFTpCreated(uint256 indexed id, string _tokenURI,  string _GMipfsHash);
    event UpdateGMpCreated(uint256 indexed id, uint256 indexed pGI, string _tokenURI,  string _GMipfsHash);
    event ProposalCreated(uint256 indexed id, string name, uint256 indexed pGI);
    event ProposalClosed(uint256 indexed id, string name);
    event ProposalApprovalSubmitted(
        uint256 indexed id,
        address indexed approver,
        string name, 
        uint256 numApprovals,
        uint256 minApprovals
    );
    event ProposalExecutable(
        uint256 indexed id,
        string name
    );
    event ProposalExecuted(uint256 indexed id, string name);

        /**
     * @notice Ensure that the proposal is open
     * @param proposalId    Proposal ID
     */
    modifier proposalIsOpen(uint256 proposalId, bool executable) {
        ProposalState state = _proposals[proposalId].state;
        if(!executable)
            require(state == ProposalState.Open, "MultiSigC: proposal is not open");
        else
            require(state == ProposalState.Open || state == ProposalState.Executable, "MultiSigC: proposal is not open");
        _;
    }

        /**
     * @notice Ensure that the proposal is open
     * @param proposalId    Proposal ID
     */
    modifier proposalIsExecutable(uint256 proposalId) {
        ProposalState state = _proposals[proposalId].state;
        require(
                state == ProposalState.Executable,
            "MultiSigC: proposal is not Executable"
        );
        _;
    }

    modifier onlyODAOM(){
        require(IDAOMTC(ODAOMTCAddr).balanceOf(_msgSender()) == 1, "MultiSigC:caller is not ODAO member");
        _;
    }

    constructor (address payable _DAOFLCAddr, address payable _ODAOMTCAddr) {
        DAOFLCAddr = _DAOFLCAddr;
        ODAOMTCAddr = _ODAOMTCAddr;

        ContractCallType storage callType1 = _types[bytes4(keccak256("createFLNFT(string,string)"))];
        _typeKeys.push(bytes4(keccak256("createFLNFT(string,string)")));
        Configuration storage config1 = callType1.config;
        config1.configName = "createFLNFT";
        config1.maxOpenProposals = 3;

        ContractCallType storage callType2 = _types[bytes4(keccak256("Initiate_LMUs(uint256)"))];
        _typeKeys.push(bytes4(keccak256("Initiate_LMUs(uint256)")));
        Configuration storage config2 = callType2.config;
        config2.configName = "Initiate_LMUs";
        config2.maxOpenProposals = 1;

        ContractCallType storage callType3 = _types[bytes4(keccak256("Cease_LMUs(uint256)"))];
        _typeKeys.push(bytes4(keccak256("Cease_LMUs(uint256)")));
        Configuration storage config3 = callType3.config;
        config3.configName = "Cease_LMUs";
        config3.maxOpenProposals = 1;

        ContractCallType storage callType4 = _types[bytes4(keccak256("setLMUVDRF(uint256)"))];
        _typeKeys.push(bytes4(keccak256("setLMUVDRF(uint256)")));
        Configuration storage config4 = callType4.config;
        config4.configName = "setLMUVDRF";
        config4.maxOpenProposals = 1;

        ContractCallType storage callType5 = _types[bytes4(keccak256("UpdateGM(uint256,string,string)"))];
        _typeKeys.push(bytes4(keccak256("UpdateGM(uint256,string,string)")));
        Configuration storage config5 = callType5.config;
        config5.configName = "UpdateGM";
        config5.maxOpenProposals = 3;
    }
    
    function transferOwnership(address newOwner) public onlyOwner { 
        require(newOwner != address(0), "NOWN0"); //Ownable: new owner is the zero address
        _transferOwnership(newOwner);
    }

    function contains(bytes4[] memory arr, bytes4 selector) internal pure returns (bool) {
    for (uint i = 0; i < arr.length; i++) {
        if (arr[i] == selector) {
            return true;
        }
    }
    return false;
}

    // Function to get all the keys in the mapping.
    function getSelectors() public view returns (bytes4[] memory) {
        return _typeKeys;
    }

    /**
     * @notice Propose a contract call
     * @dev Emits the proposal ID in ProposalCreated event.
     * @return Proposal ID
     */
    function proposecreateFLNFT(
        string memory _tokenURI, string memory _GMCID
    )
        external
        onlyOwner
        returns (uint256)
    {
        require(!createFLNFTf,"createFLNFT already executed");
        bytes4 selector = bytes4(keccak256("createFLNFT(string,string)"));
        bytes memory argumentData = abi.encode(_tokenURI, _GMCID);
        uint256 proposalID = _propose(selector, argumentData);

        if(proposalID>0){
            
            emit createFLNFTpCreated(proposalID, _tokenURI,  _GMCID);
            pGI[proposalID]=0;
            tokenURIs[proposalID]=_tokenURI;
            GMCIDs[proposalID]=_GMCID;
        }

        return proposalID;
    }

    /**
     * @notice Propose a contract call
     * @dev Emits the proposal ID in ProposalCreated event.
     * @return Proposal ID
     */
    function proposeUpdateGM(
        uint _pGI, string memory _tokenURI, string memory _GMCID
    )
        external
        onlyOwner
        returns (uint256)
    {
        require(createFLNFTf,"execute createFLNFT first");
        require(_pGI==GI,"given GI not valid");
        require(executionf[GI][bytes4(keccak256("setLMUVDRF(uint256)"))],"execute setLMUVDRF first");
        bytes4 selector = bytes4(keccak256("UpdateGM(uint256,string,string)"));
        bytes memory argumentData = abi.encode(_pGI,_tokenURI, _GMCID);
        uint256 proposalID = _propose(selector, argumentData);
        if(proposalID>0){
            
            emit UpdateGMpCreated(proposalID, _pGI, _tokenURI,  _GMCID);
            pGI[proposalID]=_pGI;
            tokenURIs[proposalID]=_tokenURI;
            GMCIDs[proposalID]=_GMCID;
        }
        return proposalID;
    }

        /**
     * @notice Propose a contract call
     * @dev Emits the proposal ID in ProposalCreated event.
     * @return Proposal ID
     */
    function propose(
        bytes4 selector, uint _pGI
    )
        external
        onlyOwner
        returns (uint256)
    {
        require(createFLNFTf,"execute createFLNFT first");
        require(_pGI==GI,"given GI not valid");
        require(selector!=bytes4(keccak256("createFLNFT(string,string)")) && selector!=bytes4(keccak256("UpdateGM(uint256,string,string)")),"given selector not valid here" );
        require(contains(_typeKeys, selector),"given selector not valid");
        require(!executionf[GI][selector],"selector already executed for current GI");
        
        if(selector==bytes4(keccak256("Cease_LMUs(uint256)"))){
            require(executionf[GI][bytes4(keccak256("Initiate_LMUs(uint256)"))],"execute Initiate_LMUs first");
        }

        if(selector==bytes4(keccak256("setLMUVDRF(uint256)"))){
            require(executionf[GI][bytes4(keccak256("Cease_LMUs(uint256)"))],"execute Cease_LMUs first");
        }
        

        bytes memory argumentData = abi.encode(_pGI);

        uint256 proposalID = _propose(selector, argumentData);
        string memory _configName = _types[selector].config.configName;
        if(proposalID>0){
            emit ProposalCreated(proposalID, _configName, _pGI);
            pGI[proposalID]=_pGI;
        }
        return proposalID;
    }


        /**
     * @notice Private function to create a new proposal
     * @param selector          Selector of the function in the contract
     * @param argumentData      ABI-encoded argument data
     * @return Proposal ID
     */
    function _propose(
        bytes4 selector,
        bytes memory argumentData
    ) private returns (uint256) {
        require(contains(_typeKeys, selector),"given selector not valid");

        ContractCallType storage callType = _types[selector];
        uint256 numOpenProposals = callType.numOpenProposals;
        require(
            numOpenProposals < callType.config.maxOpenProposals,
            "MultiSigC: Maximum open proposal limit reached"
        );
        _ProposalId.increment();
        uint256 proposalId = _ProposalId.current();

        Proposal storage proposal = _proposals[proposalId];
        proposal.state = ProposalState.Open;
        proposal.selector = selector;
        proposal.argumentData = argumentData;

        // Increment open proposal count 
        callType.numOpenProposals = numOpenProposals+1;

        // Add proposal ID to the set of open proposals
        callType.openProposals.add(proposalId);

        return proposalId;
    }

    /**
     * @notice Close a proposal without executing
     * @dev This can only be called by the proposer.
     * @param proposalId    Proposal
     */
    function closeProposal(uint256 proposalId)
        external
        proposalIsOpen(proposalId, true)
        onlyOwner
    {
        require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        _closeProposal(proposalId);
    }

    /**
     * @notice Private function to close a proposal
     * @param proposalId    Proposal ID
     */
    function _closeProposal(uint256 proposalId) private {
        require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        Proposal storage proposal = _proposals[proposalId];

        // Update state to Closed
        proposal.state = ProposalState.Closed;

        ContractCallType storage callType = _types[proposal.selector];

        // Remove proposal from openProposals
        callType.openProposals.remove(proposalId);
        callType.numOpenProposals = callType
            .numOpenProposals-1;
        string memory _configName = _types[proposal.selector].config.configName;
        emit ProposalClosed(proposalId,_configName);
    }

        /**
     * @notice Submit an approval for a proposal
     * @dev Only the approvers for the type of contract call specified in the
     * proposal are able to submit approvals.
     * @param proposalId    Proposal ID
     */
    function approve(uint256 proposalId)
        external
        proposalIsOpen(proposalId, false)
        onlyODAOM
    {
        require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        _approve(msg.sender, proposalId);
    }


     /**
     * @notice Private function to add an approval to a proposal
     * @param approver      Approver's address
     * @param proposalId    Proposal ID
     */
    function _approve(address approver, uint256 proposalId) private {
        Proposal storage proposal = _proposals[proposalId];
        EnumerableSet.AddressSet storage approvals = proposal.approvals;
        require(pGI[proposalId]==GI,"can not approve proposal,pGI invalid");
        require(
            !approvals.contains(approver),
            "MultiSigC: caller has already approved the proposal"
        );
        address[] memory toRemove = new address[](approvals.length());
        uint removeIndex = 0;
        for (uint i = 0; i < approvals.length(); i++) {
            address element = approvals.at(i);
            // Check if the element satisfies the criteria
            if (IDAOMTC(ODAOMTCAddr).balanceOf(element)!=1) {
                // Add the element to the list of elements to remove
                toRemove[removeIndex] = element;
                removeIndex++;
            } 
        }

        // Remove the elements that didn't satisfy the criteria
        for (uint i = 0; i < removeIndex; i++) {
            approvals.remove(toRemove[i]);
        }



        approvals.add(approver);

        uint256 numApprovals = proposal.approvals.length();
        uint256 minApprovals =  IDAOMTC(ODAOMTCAddr).totalSupply()*60/100; 

        string memory _configName = _types[proposal.selector].config.configName;

        emit ProposalApprovalSubmitted(
            proposalId,
            approver,
            _configName,
            numApprovals,
            minApprovals
        );

        // if the required number of approvals is met, mark it as executable
        if (numApprovals > minApprovals) {
            proposal.state = ProposalState.Executable;
            emit ProposalExecutable(proposalId,_configName);
        }
    }

    /**
     * @notice Execute an approved proposal
     * @dev Required number of approvals must have been met; only the approvers
     * for a given type of contract call proposed are able to execute.
     * @param proposalId    Proposal ID
     * @return Return data from the contract call
     */
    function execute(uint256 proposalId)
        external
        payable
        proposalIsExecutable(proposalId)
        onlyOwner
        returns (bytes memory)
    {
        require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        return _execute(proposalId);
    }

    /**
     * @notice Private function to execute a proposal
     * @dev Before calling this function, be sure that the state of the proposal
     * is Open.
     * @param proposalId    Proposal ID
     */
    function _execute(uint256 proposalId)
        private
        returns (bytes memory)
    {   require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        Proposal storage proposal = _proposals[proposalId];
        address targetContract = DAOFLCAddr;
        require(pGI[proposalId]==GI,"can not execute proposal,pGI invalid");
        
        require(
            Address.isContract(targetContract),
            "MultiSigC: targetContract is not a contract"
        );
        bytes4 selector = proposal.selector;

        if(selector==bytes4(keccak256("createFLNFT(string,string)"))){
            require(!executionf[0][bytes4(keccak256("createFLNFT(string,string))"))],"createFLNFT already executed");
        }
            
        if(selector==bytes4(keccak256("Initiate_LMUs(uint256)"))){
            require(!executionf[GI][bytes4(keccak256("Initiate_LMUs(uint256)"))],"Initiate_LMUs already executed");
        }

        else if(selector==bytes4(keccak256("Cease_LMUs(uint256)"))){
            require(!executionf[GI][bytes4(keccak256("Cease_LMUs(uint256)"))],"Cease_LMUs already executed" );
        }

        else if(selector==bytes4(keccak256("setLMUVDRF(uint256)"))){
            require(!executionf[GI][bytes4(keccak256("setLMUVDRF(uint256)"))],"setLMUVDRF already executed" );
        }
        

        
        ContractCallType storage callType = _types[selector];

        bool success;
        bytes memory returnData;

        
        (success, returnData) = targetContract.call{ value: msg.value }(
            abi.encodePacked(selector, proposal.argumentData)
        );
        

        if (!success) {
            string memory err = "MultiSigC: call failed";

            // Return data will be at least 100 bytes if it contains the reason
            // string: Error(string) selector[4] + string offset[32] + string
            // length[32] + string data[32] = 100
            if (returnData.length < 100) {
                revert(err);
            }

            // If the reason string exists, extract it, and bubble it up
            string memory reason;
            assembly {
                // Skip over the bytes length[32] + Error(string) selector[4] +
                // string offset[32] = 68 (0x44)
                reason := add(returnData, 0x44)
            }

            revert(string(abi.encodePacked(err, ": ", reason)));
        }
        else{

            // Remove the proposal ID from openProposals
            callType.openProposals.remove(proposalId);
            callType.numOpenProposals = callType
                .numOpenProposals-1;
            // Mark the proposal as executed
            proposal.state = ProposalState.Executed;
            string memory _configName = _types[selector].config.configName;
            emit ProposalExecuted(proposalId, _configName);
            executionf[GI][selector]=true;
            if(selector==bytes4(keccak256("createFLNFT(string,string)")) || selector==bytes4(keccak256("UpdateGM(uint256,string,string)"))){
                GI=GI+1;
            }

            if(selector==bytes4(keccak256("createFLNFT(string,string)")) ){
                createFLNFTf=true;
            }

            

        }

        return returnData;
    }

    function getProposal(uint256 proposalId) public view returns (
        ProposalState,
        bytes4, //selector of proposal
        string memory,
        bytes memory ,
        address[] memory,
        uint256,
        uint256,
        uint256,
        string memory,
        string memory
    ){
        require(proposalId!=0 && proposalId<=_ProposalId.current(), "proposalId not valid");
        Proposal storage proposal = _proposals[proposalId];
        string memory uri="";
        string memory gmCID="";


        uint256 numApprovals = EnumerableSet.length(proposal.approvals);
        address[] memory approvalsArray = new address[](numApprovals);
        for (uint256 i = 0; i < numApprovals; i++) {
            approvalsArray[i] = EnumerableSet.at(proposal.approvals, i);
        }
        if(proposal.selector==bytes4(keccak256("createFLNFT(string,string)")) || proposal.selector==bytes4(keccak256("UpdateGM(uint256,string,string)"))){
            uri=tokenURIs[proposalId];
            gmCID=GMCIDs[proposalId];
        }
        return (
        proposal.state, //state of proposal
        proposal.selector, //selector of proposal
         _types[proposal.selector].config.configName, //configName of proposal
        proposal.argumentData, 
        approvalsArray, // address of those who approve this proposal
        pGI[proposalId], //  GI if exist
        numApprovals, // current approvals
        IDAOMTC(ODAOMTCAddr).totalSupply()*60/100, // required approvals if not approved yet
        uri, // uri if applicable
        gmCID
        );
    }

    function getConfigNamebySelector(bytes4 selector) public view returns( string memory){
        return _types[selector].config.configName;
        
    }

}
