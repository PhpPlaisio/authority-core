<?php

namespace SetBased\Abc\Authority;

use SetBased\Abc\Abc;

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
    return !empty(Abc::$DL->abcAuthGetPageAuth(Abc::$companyResolver->getCmpId(), Abc::$session->getProId(), $pagId));
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
    Abc::$DL->abcUserRoleGrantRole(Abc::$companyResolver->getCmpId(), $usrId, $rolId, date('Y-m-d'), '9999-12-31');
    Abc::$DL->abcProfileProperUser(Abc::$companyResolver->getCmpId(), $usrId);
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
    Abc::$DL->abcAuthorityCoreUserHasAccessToPage(Abc::$companyResolver->getCmpId(), $usrId, $pagId);
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
    Abc::$DL->abcUserRoleRevokeRole(Abc::$companyResolver->getCmpId(), $usrId, $rolId);
    Abc::$DL->abcProfileProperUser(Abc::$companyResolver->getCmpId(), $usrId);
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
    $roles = Abc::$DL->abcSystemRoleGroupGetRoles($rlgId);
    foreach ($roles as $role)
    {
      Abc::$DL->abcUserRoleRevokeRole(Abc::$companyResolver->getCmpId(), $usrId, $role['rol_id']);
    }
    Abc::$DL->abcProfileProperUser(Abc::$companyResolver->getCmpId(), $usrId);
  }

  //--------------------------------------------------------------------------------------------------------------------
}

//----------------------------------------------------------------------------------------------------------------------
