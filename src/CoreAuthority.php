<?php
//----------------------------------------------------------------------------------------------------------------------
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
  public function hasAccessToPage($pagId)
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
   * @since 1.0.0
   * @api
   */
  public function userGrantRole($usrId, $rolId)
  {
    Abc::$DL->abcUserRoleGrantRole(Abc::$companyResolver->getCmpId(), $usrId, $rolId, date('Y-m-d'), '9999-12-31');
    Abc::$DL->abcProfileProper();
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes a role from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rolId The ID of the role.
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRole($usrId, $rolId)
  {
    Abc::$DL->abcUserRoleRevokeRole(Abc::$companyResolver->getCmpId(), $usrId, $rolId);
    Abc::$DL->abcProfileProper();
  }

  //--------------------------------------------------------------------------------------------------------------------
  /**
   * Revokes all roles of a role group from a user.
   *
   * @param int $usrId The ID of the user.
   * @param int $rlgId The ID of the role group.
   *
   * @since 1.0.0
   * @api
   */
  public function userRevokeRoleGroup($usrId, $rlgId)
  {
    $roles = Abc::$DL->abcSystemRoleGroupGetRoles($rlgId);
    foreach ($roles as $role)
    {
      Abc::$DL->abcUserRoleRevokeRole(Abc::$companyResolver->getCmpId(), $usrId, $role['rol_id']);
    }
    Abc::$DL->abcProfileProper();
  }

  //--------------------------------------------------------------------------------------------------------------------
}

//----------------------------------------------------------------------------------------------------------------------
