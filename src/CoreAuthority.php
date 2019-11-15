<?php
declare(strict_types=1);

namespace Plaisio\Authority;

use Plaisio\Kernel\Nub;

/**
 * Core implementation of Authority.
 */
class CoreAuthority implements Authority
{
  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Returns true if the current user has access to a page.
   *
   * @param int $pagId The ID of the page.
   *
   * @return bool
   *
   * @since 1.0.0
   * @api
   */
  public function hasAccessToPage(int $pagId): bool
  {
    return !empty(Nub::$DL->abcAuthGetPageAuth(Nub::$companyResolver->getCmpId(), Nub::$session->getProId(), $pagId));
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Grants a role to a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rolId The ID of the role.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userGrantRole(int $usrId, int $rolId): void
  {
    Nub::$DL->abcUserRoleGrantRole(Nub::$companyResolver->getCmpId(), $usrId, $rolId, date('Y-m-d'), '9999-12-31');
    Nub::$DL->abcProfileProperUser(Nub::$companyResolver->getCmpId(), $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Returns true if a user has access to a page.
   *
   * @param int $usrId The ID of the user.
   * @param int $pagId The ID of the page.
   *
   * @return bool
   *
   * @since 1.0.0
   * @api
   */
  public function userHasAccessToPage(int $usrId, int $pagId): bool
  {
    return Nub::$DL->abcAuthorityCoreUserHasAccessToPage(Nub::$companyResolver->getCmpId(), $usrId, $pagId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes a role from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rolId The ID of the role.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRole(int $usrId, int $rolId): void
  {
    Nub::$DL->abcUserRoleRevokeRole(Nub::$companyResolver->getCmpId(), $usrId, $rolId);
    Nub::$DL->abcProfileProperUser(Nub::$companyResolver->getCmpId(), $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes all roles of a role group from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rlgId The ID of the role group.
   *
   * @return void
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRoleGroup(int $usrId, int $rlgId): void
  {
    $roles = Nub::$DL->abcSystemRoleGroupGetRoles($rlgId);
    foreach ($roles as $role)
    {
      Nub::$DL->abcUserRoleRevokeRole(Nub::$companyResolver->getCmpId(), $usrId, $role['rol_id']);
    }
    Nub::$DL->abcProfileProperUser(Nub::$companyResolver->getCmpId(), $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
}

//----------------------------------------------------------------------------------------------------------------------
